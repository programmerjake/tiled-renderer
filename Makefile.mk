.PHONY: all clean always_build
.DELETE_ON_ERROR:
BUILD_DIR := build
OUTPUT_FILE := $(BUILD_DIR)/tiled-renderer
SDL_CFLAGS := $(shell sdl2-config --cflags)
SDL_LIBS := $(shell sdl2-config --static-libs)

always_build:

#DEBUG_MODE := on

OBJECT_FILES += $(BUILD_DIR)/main.o

$(BUILD_DIR)/main.o: main.cpp image.h matrix_list.h value_list.h vector_list.h

ifeq "$(DEBUG_MODE)" ""

$(BUILD_DIR)/%.o: %.cpp always_build
	{ mkdir -p $(BUILD_DIR); rm -f $(OUTPUT_FILE); }; clang++ -mavx -pthread -stdlib=libc++ -c -std=c++11 -O3 -g $(SDL_CFLAGS) $< -o $@

SDL_LIBS := $(filter-out -lSDL2,$(SDL_LIBS))

$(OUTPUT_FILE): $(OBJECT_FILES)
	clang++ -pthread -stdlib=libc++ $+ -o $@ -Wl,-Bstatic -lc++ -lSDL2 -Wl,-Bdynamic $(SDL_LIBS)

else

$(BUILD_DIR)/%.o: %.cpp always_build
	{ mkdir -p $(BUILD_DIR); rm -f $(OUTPUT_FILE); }; clang++ -fsanitize=address -mavx -pthread -stdlib=libc++ -c -std=c++11 -O0 -g $(SDL_CFLAGS) $< -o $@

$(OUTPUT_FILE): $(OBJECT_FILES)
	clang++ -fsanitize=address -pthread -stdlib=libc++ $+ -o $@ $(SDL_LIBS)

endif

all: $(OUTPUT_FILE)

clean:
	rm -f $(OBJECT_FILES) $(OUTPUT_FILE)