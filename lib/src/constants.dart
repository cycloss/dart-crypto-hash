// to restrict dart's 64 bit int to 32 bits
// everything outside the range of this mask will be dropped
// also allows checking that 64 bit ints contain no 1s beyond the 32nd bit
const BIT_MASK_32 = 0xffffffff;
