CC := cc
CFLAGS := -Wall -Wextra -Werror # -Ofast
DEBUG_FLAGS := -g -O0
NAME := push_swap
BONUS_NAME := checker

# .h files
H_FILES := $(wildcard include/*.h)

# .c files
SRC_DIR := src/base src/checker src/push_swap
vpath %.c $(SRC_DIR)
BASE_SRC_FILES := ft_free_content.c ft_free_push_swap.c ft_get_prev.c ft_init_lst_indexes.c ft_init_push_swap.c ft_is_sorted.c ft_print_error.c ft_print_push_swap.c ft_print_stack.c ft_push.c ft_reverse_rotate.c ft_rotate.c ft_value_is_smallest.c ft_value_present.c swap.c
PUSH_SWAP_SRC_FILES := ft_10sort.c ft_2sort.c ft_3sort.c ft_bubble_sort.c ft_debug_sort.c ft_get_content.c ft_get_diff.c ft_get_index_distance.c ft_get_max_stack_index.c ft_get_min_stack_index.c ft_get_stack_index.c ft_go_to_index.c ft_go_to_indexes.c ft_improved_sort_back.c ft_improved_sort_in_b.c ft_k_sort.c ft_move_to_start.c ft_proxy_sort.c ft_proxy_sort_prototype.c ft_push_back.c ft_sort.c ft_sort_back.c ft_sort_in_b.c ft_stalin_sort.c push_swap_main.c
CHECKER_SRC_FILES := checker_main.c ft_read_instructions.c

# .o files
OBJ_DIR := obj
BASE_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(BASE_SRC_FILES:.c=.o))
PUSH_SWAP_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(PUSH_SWAP_SRC_FILES:.c=.o))
CHECKER_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(CHECKER_SRC_FILES:.c=.o))

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

# Link push_swap
$(NAME): $(LIBS) $(BASE_OBJ_FILES) $(PUSH_SWAP_OBJ_FILES)
	$(CC) $(BASE_OBJ_FILES) $(PUSH_SWAP_OBJ_FILES) $(LDFLAGS) $(LDLIBS) -o $(NAME)

# Link checker
$(BONUS_NAME): $(LIBS) $(BASE_OBJ_FILES) $(CHECKER_OBJ_FILES)
	$(CC) $(BASE_OBJ_FILES) $(CHECKER_OBJ_FILES) $(LDFLAGS) $(LDLIBS) -o $(BONUS_NAME)

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
