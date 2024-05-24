common_sources = sensirion_config.h sensirion_common.h sensirion_common.c
i2c_sources = sensirion_i2c_hal.h sensirion_i2c.h sensirion_i2c.c
scd4x_sources = scd4x_i2c.h scd4x_i2c.c

i2c_implementation?= sensirion_i2c_hal.c

# New variable for example_comma_separated sources
example_comma_separated_sources = example_comma_separated.c

CFLAGS = -Os -Wall -fstrict-aliasing -Wstrict-aliasing=1 -Wsign-conversion -fPIC -I.

ifdef CI
    CFLAGS += -Werror
endif

.PHONY: all clean example_comma_separated

all: scd4x_i2c_example_usage example_comma_separated

scd4x_i2c_example_usage: clean
	$(CC) $(CFLAGS) -o $@  ${scd4x_sources} ${i2c_sources} \
		${i2c_implementation} ${common_sources} scd4x_i2c_example_usage.c

# New target for example_comma_separated
example_comma_separated: clean
	$(CC) $(CFLAGS) -o $@  ${scd4x_sources} ${i2c_sources} \
		${i2c_implementation} ${common_sources} example_comma_separated.c

clean:
	$(RM) scd4x_i2c_example_usage example_comma_separated
