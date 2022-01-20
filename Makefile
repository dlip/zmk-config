ZMK_DIR = $(shell readlink -f ./zmk/)
ZEPHYR_DIR = $(shell readlink -f ./zephyr/)
CONFIG_DIR = $(shell readlink -f ./config/)
BOARD = nice_nano_v2
SHIELD = cradio
KEYMAP = default
SIDE = 

BUILD_SCRIPT = source $(ZEPHYR_DIR)/zephyr-env.sh; west build -p -s $(ZMK_DIR)/app -b $(BOARD) -d build/shield$${SIDE} -- -DSHIELD=$(SHIELD)$${SIDE} -DKEYMAP=$(KEYMAP) -DZMK_CONFIG=$(CONFIG_DIR)

CP_SCRIPT = cp build/shield$${SIDE}/zephyr/zmk.uf2 /run/media/dane/NICENANO/

flash:
	make left && echo 'press enter then reset' && read && sleep 5 && make cp_left

left:
	SIDE=_left; $(BUILD_SCRIPT)

cp_left:
	SIDE=_left; $(CP_SCRIPT)

right:
	SIDE=_right; $(BUILD_SCRIPT)

cp_right:
	SIDE=_right; $(CP_SCRIPT)

init:
	west init -l config

update:
	west update
	west zephyr-export
