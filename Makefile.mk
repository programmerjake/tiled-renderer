.PHONY: all clean always_build
.DELETE_ON_ERROR:
BUILD_DIR := build
OUTPUT_FILE := $(BUILD_DIR)/tiled-renderer
SDL_CFLAGS := $(shell sdl2-config --cflags)
SDL_LIBS := $(shell sdl2-config --static-libs)
SDL_LIBS := $(filter-out -lSDL2,$(SDL_LIBS))

always_build:

$(BUILD_DIR)/%.o: %.cpp always_build
	{ mkdir -p $(BUILD_DIR); rm -f $(OUTPUT_FILE); }; clang++ -mavx -pthread -stdlib=libc++ -c -std=c++11 -O3 -g $(SDL_CFLAGS) $< -o $@

OBJECT_FILES += $(BUILD_DIR)/main.o

$(BUILD_DIR)/main.o: main.cpp image.h matrix_list.h value_list.h vector_list.h

$(OUTPUT_FILE): $(OBJECT_FILES)
	clang++ -pthread -stdlib=libc++ $+ -o $@ -Wl,-Bstatic -lc++ -lSDL2 -Wl,-Bdynamic $(SDL_LIBS)

all: $(OUTPUT_FILE)

clean:
	rm -f $(OBJECT_FILES) $(OUTPUT_FILE)