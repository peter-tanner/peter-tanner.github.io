
unsigned char get_checksum(unsigned char array[], unsigned char array_size)
{
    unsigned char checksum = 0;
    for (unsigned char i = 1; i < array_size - 2; i++)
        checksum += array[i];
    checksum = (~checksum) + 1;
    return checksum;
}