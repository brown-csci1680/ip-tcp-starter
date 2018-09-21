CC = gcc -O3
CFLAGS = -g -Wall -Wextra -Werror -D_REENTRANT -DCOLOR \
				 -D__BSD_VISIBLE -DREADLINE -Isupport -I.
LDFLAGS = -lpthread -lreadline

SRCS = node.c support/dbg.c support/parselinks.c

all: node 

node : $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f node 
