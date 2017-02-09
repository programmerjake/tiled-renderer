.PHONY: all clean
.DELETE_ON_ERROR:
BUILD_DIR := build
SOURCE_FILES := $(wildcard *.cpp)
OBJECT_FILES := $(SOURCE_FILES:%.cpp=$(BUILD_DIR)/%.o)
OUTPUT_FILE := $(BUILD_DIR)/tiled-renderer
SDL_CFLAGS := $(shell sdl2-config --cflags)
SDL_LIBS := $(shell sdl2-config --libs)

$(BUILD_DIR)/%.o: %.cpp
	mkdir -p $(BUILD_DIR) && clang++ -stdlib=libc++ -c -std=c++11 -O2 -g $(SDL_CFLAGS) $< -o $@

$(OUTPUT_FILE): $(OBJECT_FILES)
	clang++ -stdlib=libc++ $(SDL_LIBS) $+ -o $@

all: $(OUTPUT_FILE)

clean:
	rm -f $(OBJECT_FILES) $(OUTPUT_FILE)