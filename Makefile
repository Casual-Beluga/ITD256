DB=jelkner
BUILD=${CURDIR}/build.sql
SCRIPTS=${CURDIR}/scripts
CSV='/usr/local/share/data/curious_moon/master_plan.csv'
MAIN=$(SCRIPTS)/import.sql
NORMALIZE = $(SCRIPTS)/normalize.sql 

all: normalize
	psql $(DB) -f $(BUILD)

main:
	@cat $(MAIN) >> $(BUILD)

import: main
	@echo "COPY import.master_plan FROM $(CSV) WITH DELIMITER ',' HEADER CSV;" >> $(BUILD)

normalize: import
	@cat $(NORMALIZE) >> $(BUILD)

clean:
	@rm -rf $(BUILD)
