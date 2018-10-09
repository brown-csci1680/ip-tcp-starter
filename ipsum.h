#ifndef IPSUM_H
#define IPSUM_H

#include <inttypes.h>

// do an ip checksum on a generic block of memory
// for IP, len should always be the size of the ip header (sizeof (struct ip))
static inline int ip_sum(char* packet, int len) {
  uint16_t *p = (uint16_t*)packet;
  uint16_t answer;
  long sum = 0;
  uint16_t odd_byte = 0;

  while (len > 1) {
    sum += *p++;
    len -= 2;
  }

  /* mop up an odd byte, if necessary */
  if (len == 1) {
    *(uint8_t*)(&odd_byte) = *(uint8_t*)p;
    sum += odd_byte;
  }

  sum = (sum >> 16) + (sum & 0xffff); /* add hi 16 to low 16 */
  sum += (sum >> 16);           /* add carry */
  answer = ~sum;                /* ones-complement, truncate*/
  return answer;
}

#endif
