#!/usr/bin/env python

import sys

def current_brightness():
    brightness = -1

    with open('/sys/class/backlight/intel_backlight/brightness', 'r') as f:
        brightness = f.read()

    return int(brightness)

def max_brightness():
    max_brightness = -1

    with open('/sys/class/backlight/intel_backlight/max_brightness', 'r') as f:
        max_brightness = f.read()

    return int(max_brightness)

def adjust_brightness(percent):
    max = max_brightness()

    new_brightness = int(max * percent * 0.01)

    with open('/sys/class/backlight/intel_backlight/brightness', 'w') as f:
        f.write(str(new_brightness))

    return new_brightness

def main():
    if len(sys.argv) < 2:
        try:
            cur_b = current_brightness()
            max_b = max_brightness()

        except Exception, err:
            print 'Could not read current backlight level: {0}'.format(str(err))
        else:
            print 'Backlight is currently set to {:.0%}.'.format(cur_b / float(max_b))
    else:
        percent = int(sys.argv[1])

        try:
            adjust_brightness(percent)
        except Exception, err:
            print 'Could not set backlight level: {0}'.format(str(err))
        else:
            print 'Backlight has been set to {0}%.'.format(percent)

if __name__ == "__main__":
    main()

