#ifndef MBR_H
#define MBR_H

#include <stdint.h>

typedef struct __attribute__((packed)) partition_table_entry_t {
    uint8_t indicator;
    uint8_t head;
    /* Unused. */
    uint8_t _sector : 6;
    uint32_t cylinder;
    uint8_t system_id;
    /* The rest is unused (32 bits, duh). */
    uint32_t _;
} parition_table_entry;

#endif /* MBR_H */

