CC := cc
CFLAGS := -Wall -Wextra -Werror # -Ofast
DEBUG_FLAGS := -g -O0
NAME := 
BONUS_NAME := checker

# .h files
H_FILES := include/include.h

# .c files
SRC_DIR := src/base src/default src/bonus
vpath %.c $(SRC_DIR)
BASE_SRC_FILES := base_utils.c
DEFAULT_SRC_FILES := default_main.c
BONUS_SRC_FILES := bonus_main.c

# .o files
OBJ_DIR := obj
BASE_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(BASE_SRC_FILES:.c=.o))
DEFAULT_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(DEFAULT_SRC_FILES:.c=.o))
BONUS_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(BONUS_SRC_FILES:.c=.o))

# libft
LIBFT_DIR := libft
LIBFT := $(LIBFT_DIR)/libft.a

# includes
INCLUDES := -I include -I libft
LIBS := $(LIBFT)
LDFLAGS := -L$(LIBFT_DIR)
LDLIBS := -lft

# all
all: $(NAME)

# bonus
bonus: $(BONUS_NAME)

# Link default
$(NAME): $(LIBS) $(BASE_OBJ_FILES) $(DEFAULT_OBJ_FILES)
	$(CC) $(BASE_OBJ_FILES) $(DEFAULT_OBJ_FILES) $(LDFLAGS) $(LDLIBS) -o $(NAME)

# Link bonus
$(BONUS_NAME): $(LIBS) $(BASE_OBJ_FILES) $(BONUS_OBJ_FILES)
	$(CC) $(BASE_OBJ_FILES) $(BONUS_OBJ_FILES) $(LDFLAGS) $(LDLIBS) -o $(BONUS_NAME)

# Compile BASE_OBJ_FILES
$(OBJ_DIR)/%.o: %.c $(H_FILES) $(LIBFT) | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(LIBFT):
	$(MAKE) -C $(LIBFT_DIR)

# clean
clean:
	$(RM) -r $(OBJ_DIR)
	$(MAKE) -C $(LIBFT_DIR) clean

# fclean
fclean:
	$(RM) -rf $(OBJ_DIR)
	$(RM) -f $(NAME) $(BONUS_NAME)
	$(MAKE) -C $(LIBFT_DIR) fclean

# re
re: fclean all

# debug
debug: CFLAGS += $(DEBUG_FLAGS)
debug: re bonus

.PHONY: all clean fclean re debug bonus
