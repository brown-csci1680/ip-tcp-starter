CC = gcc
CFLAGS = -g -Wall -Wextra -Werror -D_REENTRANT -DCOLOR \
				 -D__BSD_VISIBLE -DREADLINE -Isupport -I.
LDFLAGS = -lpthread -lreadline

SRCS = node.c dbg.c parselinks.c

all: node 

node : $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f node 
