#!/bin/bash

## Don't Use it 
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space > /dev/null

exec "$@"

