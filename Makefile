ZMK_DIR = $(shell readlink -f ./zmk/)
ZEPHYR_DIR = $(shell readlink -f ./zephyr/)
CONFIG_DIR = $(shell readlink -f ./config/)
BOARD = nice_nano_v2
SHIELD = cradio
KEYMAP = default
SIDE = 

BUILD_SCRIPT = source $(ZEPHYR_DIR)/zephyr-env.sh; west build -p -s $(ZMK_DIR)/app -b $(BOARD) -d build/shield$${SIDE} -- -DSHIELD=$(SHIELD)$${SIDE} -DKEYMAP=$(KEYMAP) -DZMK_CONFIG=$(CONFIG_DIR)

left:
	SIDE=_left; $(BUILD_SCRIPT)

cp_left:
	cp build/shield_left/zephyr/zmk.uf2 /run/media/dane/NICENANO/

right:
	SIDE=_right; $(BUILD_SCRIPT)

cp_right:
	cp build/shield_left/zephyr/zmk.uf2 /run/media/dane/NICENANO/
