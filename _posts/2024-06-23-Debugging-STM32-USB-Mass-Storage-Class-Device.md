---
title: Debugging STM32 USB Mass Storage Class Device with eMMC
author: peter
date: 2024-06-23 22:25:56 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, emmc, embedded] # systems | embedded | rf | microwave | electronics | solidworks | automation
# image: assets/img/2024-06-23-Debugging-STM32-USB-/preview.png
---

Summary of my thought process when troubleshooting a board containing eMMC and USB mass storage class device on the STM32L476.

Download Wireshark and the USB pcap plugin.

TLDR: Minimum configuration you should try for troubleshooting is:

- High clock divider (try 4 or 8 or even larger values)
- 1 bit wide MMC bus
- Don't initialize MMC peripheral in the USB MSC initialization function.

## 1. USB connects but then disconnects after a few seconds. The device shows momentarily in the tray, but is not assigned a driver letter.

This also shows in wireshark when the response from the device is a `GET MAX LUN Response[Malformed Packet]` packet.

![wireshark packet capture with malformed packet](/assets/img/2024-06-23-Debugging-STM32-USB-/wireshark.png)

Try return `USBD_OK` for the all functions except `STORAGE_GetMaxLun_FS`. It should show up in explorer with a drive letter and should not disconnect.

This means the functions interacting with the storage device are not working.

---

Make sure you are not re-initializing the MMC peripheral in the `STORAGE_Init_FS` function. This is because in the initialization of the MMC peripheral, `HAL_Delay` is called twice. The use of `HAL_Delay` while the USB device is active appears to cause issues with mounting the device.

<!-- ### 1.1 Try disable eMMC or SD card first

In my board I had eMMC, by commenting out code I isolated the issue to the `SDMMC_PowerState_ON` function which is called during the device initialization. When this code was not called the drive showed up with a drive leter, but when the code was called the drive was not mounted.

```c
(void)SDMMC_PowerState_ON(hmmc->Instance);
```

From this I concluded that any calls to `HAL_Delay` were causing the USB stack to break.

Commenting out the `HAL_Delay` in the `SDMMC_PowerState_ON` function and the one to wait 74 cycles (`HAL_Delay(1U + (74U * 1000U / (sdmmc_clk)))`) caused it to mount properly. I still have to think about what is happening since obviously the delays appear to have good reasons for existing. -->

## 2. "This request is not supported" when formatting drive, files not readable

Try changing the clock division to something larger like `4` or greater. Once it is stable try decreasing the divider to maximize speed. When I used lower values, the bus was unstable and I could not retrieve files or perform format operations.

> **EDIT: It's now working with 4-bit bus width and 0 clock div, not sure what I did to make it work but it works. I think it might be that I increased my `SYSCLK` since when I started the project it was at the default `16 MHz` since it was using the HSI instead of the HSE.**

```c
hmmc1.Init.ClockDiv = 4;
```

## 3. Random files appearing when formatting AND using 4-bit mode

When a drive has already been formatted in 1-bit mode and you try to reformat it, the format fails and there appears to be random files in the apparently formatted drive

The format fails with:

> Windows was unable to complete the format

I guess my board doesn't work in 4-bit mode so I just compromised with 1-bit mode and it worked again.

> **EDIT: It's now working with 4-bit bus width and 0 clock div, not sure what I did to make it work but it works. I think it might be that I increased my `SYSCLK` since when I started the project it was at the default `16 MHz` since it was using the HSI instead of the HSE.**

## 4. DMA/Multiple block DMA not working on STM32L476RET6 STM32L476

Enable "SDMMC hardware flow control" under the SDMMC peripheral.

Make sure to switch the DMA direction each for RX and TX

Since we are doing bi-directional transfer just use the SDMMC1 DMA request type. Don't use SDMMC1_TX and SDMMC1_RX simulatneously since you need to switch the direction each transfer anyways.

![dma config for sdmmc1](/assets/img/2024-06-23-Debugging-STM32-USB-/dma_settings.png)

The order of preemption priority is crucial, otherwise the transfer will hang. For example `HAL_MMC_GetCardState()`, will be stuck in the `HAL_MMC_CARD_SENDING` state since the interrupt priority is wrong.

In my case I am using:

| NVIC interrupt table                                     | Preemption Priority | Sub Priority |
| -------------------------------------------------------- | ------------------- | ------------ |
| DMA2 channel4 global interrupt (Use your DMA controller) | 0                   | 0            |
| SDMMC1 global interrupt                                  | 1                   | 0            |
| USB OTG FS global interrupt                              | 2                   | 0            |

You may use any priority value but the priorities should in the same order.

![nvic priority table](/assets/img/2024-06-23-Debugging-STM32-USB-/nvic_settings.png)

## Performance with DMA but 512 packet size

Kind of terrible but I am using 1-bit bus width since 4-bit isn't working for me.

I am using the Toshiba `THGBMJG6C1LBAIL` 8G eMMC module since I thought it was cheap on JLCPCB (but see conclusion for my thoughts on eMMC).

![crystaldiskmark performance](/assets/img/2024-06-23-Debugging-STM32-USB-/crystaldiskmark.png)

> **EDIT: It's now working with 4-bit bus width and 0 clock div, not sure what I did to make it work but it works. I think it might be that I increased my `SYSCLK` since when I started the project it was at the default `16 MHz` since it was using the HSI instead of the HSE.**
>
> This caused a sizeable performance increase! However it's still quite terrible, since the eMMC module I used claims read/write speeds of 45/35 MB/s at 52 MHz in SDR mode at 3.3V. Obviously having a HAL puts overhead and this figure is probably dependant on the block size.
>
> ![crystaldiskmark performance 4bit](/assets/img/2024-06-23-Debugging-STM32-USB-/crystaldiskmark_fast.png)

## 5. MMC performance is very bad, slow write speeds

One last thing to change is the packet size. Larger packet sizes will perform better (at the cost of more memory).

Change the packet size under the `USB_DEVICE` middleware parameters:

![configure media packet size](/assets/img/2024-06-23-Debugging-STM32-USB-/packet_size_cubemx.png)

Alternatively, in `usbd_conf.h`, change:

```c
#define MSC_MEDIA_PACKET     512U
```

to some **multiple of 512**

For example:

```c
#define MSC_MEDIA_PACKET     32678U  // MUST BE A MULTIPLE OF 512
```

You may need to modify your minimum stack/heap size to accomodate for the larger packet size.

The maximum is `32678` bytes

The read/write speeds improve on the previous tests, however it is still no where near the limit of the eMMC module. Currently I have not tried anything else to improve the speed, if there is any way then let me know.

This benchmark is with the largest media packet size (32768), 4 bit wide bus, 0 clock div and DMA.

![crystaldiskmark benchmark with largest media packet size](/assets/img/2024-06-23-Debugging-STM32-USB-/crystaldiskmark_fast_large_buf.png)

## Conclusion

Overall, eMMC is mechanically robust, however from a cost perspective I wouldn't choose this in a future project unless necesary. While it appears to be cheaper than SD cards and holders, the tight tolerances require JLCPCB's 4-wire kelvin testing for the smaller vias (Unless you use 6-layer which has the pad in via for free), and requires X-ray inspection which is another fee. I wouldn't attempt soldering them manually since I've never dealt with BGA so this is a fee I had to accept.

In my next project I will try out those embedded SD card modules, they come in DFN-8 packages and should be much cheaper than eMMC while offerring high capacity than NOR flash, but they are less widely known and I would not use them in a project which is going into production, only a hobby project.

I will update this post with more cases as I run into them. Comment on your experiences debugging USB on STM32 and I'll quote them in the article.

## Sample code for eMMC and USB mass storage class device (`#define BLOCKING` for simple, non-DMA implementation)

### `main.c`

```c
static void MX_SDMMC1_MMC_Init(void)
{

  /* USER CODE BEGIN SDMMC1_Init 0 */

  /* USER CODE END SDMMC1_Init 0 */

  /* USER CODE BEGIN SDMMC1_Init 1 */

  /* USER CODE END SDMMC1_Init 1 */
  hmmc1.Instance = SDMMC1;
  hmmc1.Init.ClockEdge = SDMMC_CLOCK_EDGE_RISING;
  hmmc1.Init.ClockBypass = SDMMC_CLOCK_BYPASS_DISABLE;
  hmmc1.Init.ClockPowerSave = SDMMC_CLOCK_POWER_SAVE_ENABLE;
  hmmc1.Init.BusWide = SDMMC_BUS_WIDE_4B; // MODIFY THIS AS APPRORIATE - CHANGE TO 1 IF STUFF ISN'T WORKING
  hmmc1.Init.HardwareFlowControl = SDMMC_HARDWARE_FLOW_CONTROL_ENABLE;  // ENABLE HARDWARE FLOW CONTROL
  hmmc1.Init.ClockDiv = 0; // MODIFY THIS AS APPROPRIATE - USE A HIGHER VALUE IF STUFF ISN'T WORKING
  if (HAL_MMC_Init(&hmmc1) != HAL_OK)
  {
    Error_Handler();
  }

  // ⚠ NOTE: DO NOT FORGET TO MODIFY THIS AS WELL!!!
  if (HAL_MMC_ConfigWideBusOperation(&hmmc1, SDMMC_BUS_WIDE_1B) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN SDMMC1_Init 2 */
  /* USER CODE END SDMMC1_Init 2 */
}
```

### `usbd_storage_if.c`

````c
volatile uint8_t mmc_transaction_blks_left = 0;

void HAL_MMC_RxCpltCallback(MMC_HandleTypeDef *hmmc)
{
  mmc_transaction_blks_left = 0;
}

void HAL_MMC_TxCpltCallback(MMC_HandleTypeDef *hmmc)
{
  mmc_transaction_blks_left = 0;
}

// CHANGE DMA DIRECTION
HAL_StatusTypeDef MMC_DMA_direction(uint32_t direction)
{
  HAL_StatusTypeDef status = HAL_OK;
  hdma_sdmmc1.Init.Direction = direction;
  HAL_DMA_Abort(&hdma_sdmmc1);
  HAL_DMA_DeInit(&hdma_sdmmc1);
  return HAL_DMA_Init(&hdma_sdmmc1);
}

// MORE AUTOGENERATED CODE...
// [...]

/**
  * @brief  Initializes over USB FS IP
  * @param  lun:
  * @retval USBD_OK if all operations are OK else USBD_FAIL
  */
int8_t STORAGE_Init_FS(uint8_t lun)
{
  /* USER CODE BEGIN 2 */
  // ALREADY INITIALIZED IN `MX_SDMMC1_MMC_Init` FUNCTION.
  return USBD_OK;
  /* USER CODE END 2 */
}

/**
  * @brief  .
  * @param  lun: .
  * @param  block_num: .
  * @param  block_size: .
  * @retval USBD_OK if all operations are OK else USBD_FAIL
  */
int8_t STORAGE_GetCapacity_FS(uint8_t lun, uint32_t *block_num, uint16_t *block_size)
{
  /* USER CODE BEGIN 3 */
  HAL_MMC_CardInfoTypeDef card_info;
  HAL_StatusTypeDef status = HAL_MMC_GetCardInfo(&hmmc1, &card_info);
  *block_num = card_info.LogBlockNbr - 1;
  *block_size = card_info.LogBlockSize;
  return status;
  /* USER CODE END 3 */
}

/**
  * @brief  .
  * @param  lun: .
  * @retval USBD_OK if all operations are OK else USBD_FAIL
  */
int8_t STORAGE_IsReady_FS(uint8_t lun)
{
  /* USER CODE BEGIN 4 */
  // if (HAL_MMC_GetState(&hmmc1) == HAL_MMC_STATE_BUSY || HAL_MMC_GetCardState(&hmmc1) != HAL_MMC_CARD_TRANSFER)
  //   return USBD_FAIL;
  return USBD_OK;
  /* USER CODE END 4 */
}

/**
  * @brief  .
  * @param  lun: .
  * @retval USBD_OK if all operations are OK else USBD_FAIL
  */
int8_t STORAGE_IsWriteProtected_FS(uint8_t lun)
{
  /* USER CODE BEGIN 5 */
  // ASSUME eMMC IS NEVER WRITE PROTECTED ON THIS PARTICULAR BOARD
  // WRITE PROTECT FEATURE IS NOT USED.
  return USBD_OK;
  /* USER CODE END 5 */
}

/**
  * @brief  .
  * @param  lun: .
  * @retval USBD_OK if all operations are OK else USBD_FAIL
  */
int8_t STORAGE_Read_FS(uint8_t lun, uint8_t *buf, uint32_t blk_addr, uint16_t blk_len)
{
  /* USER CODE BEGIN 6 */
  hmmc1.ErrorCode = HAL_MMC_ERROR_NONE;
  while (HAL_MMC_GetCardState(&hmmc1) != HAL_MMC_CARD_TRANSFER)
    ; // FIXME: IMPLEMENT TIMEOUT FAILSAFE
#ifdef BLOCKING
  if (HAL_MMC_ReadBlocks(&hmmc1, buf, blk_addr, blk_len, TIMEOUT) != HAL_OK)
    return USBD_FAIL;
#else
  mmc_transaction_blks_left = 1;
  if (MMC_DMA_direction(DMA_PERIPH_TO_MEMORY) != HAL_OK)
  {
    mmc_transaction_blks_left = 0;
    return USBD_FAIL;
  }
  if (HAL_MMC_ReadBlocks_DMA(&hmmc1, buf, blk_addr, blk_len) != HAL_OK)
  {
    mmc_transaction_blks_left = 0;
    return USBD_FAIL;
  }
  while (mmc_transaction_blks_left)
    ;
#endif
  hmmc1.ErrorCode = HAL_MMC_ERROR_NONE;
  while (HAL_MMC_GetCardState(&hmmc1) != HAL_MMC_CARD_TRANSFER)
    ; // FIXME: IMPLEMENT TIMEOUT FAILSAFE
  return USBD_OK;
  /* USER CODE END 6 */
}

/**
  * @brief  .
  * @param  lun: .
  * @retval USBD_OK if all operations are OK else USBD_FAIL
  */
int8_t STORAGE_Write_FS(uint8_t lun, uint8_t *buf, uint32_t blk_addr, uint16_t blk_len)
{
  /* USER CODE BEGIN 7 */
  hmmc1.ErrorCode = HAL_MMC_ERROR_NONE;
  while (HAL_MMC_GetCardState(&hmmc1) != HAL_MMC_CARD_TRANSFER)
    ; // FIXME: IMPLEMENT TIMEOUT FAILSAFE
#ifdef BLOCKING
  if (HAL_MMC_WriteBlocks(&hmmc1, buf, blk_addr, blk_len, TIMEOUT) != HAL_OK)
    return USBD_FAIL;
#else
  mmc_transaction_blks_left = 1;
  if (MMC_DMA_direction(DMA_MEMORY_TO_PERIPH) != HAL_OK)
  {
    mmc_transaction_blks_left = 0;
    return USBD_FAIL;
  }
  if (HAL_MMC_WriteBlocks_DMA(&hmmc1, buf, blk_addr, blk_len) != HAL_OK)
  {
    mmc_transaction_blks_left = 0;
    return USBD_FAIL;
  }
  while (mmc_transaction_blks_left)
    ;
#endif
  hmmc1.ErrorCode = HAL_MMC_ERROR_NONE;
  while (HAL_MMC_GetCardState(&hmmc1) != HAL_MMC_CARD_TRANSFER)
    ; // FIXME: IMPLEMENT TIMEOUT FAILSAFE
  return USBD_OK;
  /* USER CODE END 7 */
}

/**
  * @brief  .
  * @param  None
  * @retval .
  */
int8_t STORAGE_GetMaxLun_FS(void)
{
  /* USER CODE BEGIN 8 */
  return STORAGE_LUN_NBR - 1;
  /* USER CODE END 8 */
}```
````
