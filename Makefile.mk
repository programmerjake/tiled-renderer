.PHONY: all clean
.DELETE_ON_ERROR:
BUILD_DIR := build
OUTPUT_FILE := $(BUILD_DIR)/tiled-renderer
SDL_CFLAGS := $(shell sdl2-config --cflags)
SDL_LIBS := $(shell sdl2-config --libs)

$(BUILD_DIR)/%.o: %.cpp
	mkdir -p $(BUILD_DIR) && clang++ -stdlib=libc++ -c -std=c++11 -O2 -g $(SDL_CFLAGS) $< -o $@

OBJECT_FILES += $(BUILD_DIR)/main.o

$(BUILD_DIR)/main.o: main.cpp image.h matrix_list.h value_list.h vector_list.h

$(OUTPUT_FILE): $(OBJECT_FILES)
	clang++ -stdlib=libc++ $(SDL_LIBS) -msse4 $+ -o $@

all: $(OUTPUT_FILE)

clean:
	rm -f $(OBJECT_FILES) $(OUTPUT_FILE)