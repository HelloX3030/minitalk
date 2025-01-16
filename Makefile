CC := cc
CFLAGS := -Wall -Wextra -Werror # -Ofast
DEBUG_FLAGS := -g -O0
SERVER := server
CLIENT := client
BONUS_SERVER := bonus_server
BONUS_CLIENT := bonus_client

# .h files
H_FILES := include/include.h

# .c files
SRC_DIR := src/base src/server src/client src/bonus_server src/bonus_client
vpath %.c $(SRC_DIR)
BASE_SRC_FILES := base_utils.c
SERVER_SRC_FILES := server_main.c
CLIENT_SRC_FILES := client_main.c
BONUS_SERVER_SRC_FILES := bonus_server_main.c
BONUS_CLIENT_SRC_FILES := bonus_client_main.c

# .o files
OBJ_DIR := obj
BASE_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(BASE_SRC_FILES:.c=.o))
SERVER_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(SERVER_SRC_FILES:.c=.o))
CLIENT_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(CLIENT_SRC_FILES:.c=.o))
BONUS_SERVER_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(BONUS_SERVER_SRC_FILES:.c=.o))
BONUS_CLIENT_OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(BONUS_CLIENT_SRC_FILES:.c=.o))

# libft
LIBFT_DIR := libft
LIBFT := $(LIBFT_DIR)/libft.a

# includes
INCLUDES := -I include -I libft
LIBS := $(LIBFT)
LDFLAGS := -L$(LIBFT_DIR)
LDLIBS := -lft

# all
all: $(SERVER) $(CLIENT)

# bonus
bonus: $(BONUS_SERVER) $(BONUS_CLIENT)

# Link server
$(SERVER): $(LIBS) $(BASE_OBJ_FILES) $(SERVER_OBJ_FILES)
	$(CC) $(BASE_OBJ_FILES) $(SERVER_OBJ_FILES) $(LDFLAGS) $(LDLIBS) -o $(SERVER)

# Link client
$(CLIENT): $(LIBS) $(BASE_OBJ_FILES) $(CLIENT_OBJ_FILES)
	$(CC) $(BASE_OBJ_FILES) $(CLIENT_OBJ_FILES) $(LDFLAGS) $(LDLIBS) -o $(CLIENT)

# Link bonus server
$(BONUS_SERVER): $(LIBS) $(BASE_OBJ_FILES) $(BONUS_SERVER_OBJ_FILES)
	$(CC) $(BASE_OBJ_FILES) $(BONUS_SERVER_OBJ_FILES) $(LDFLAGS) $(LDLIBS) -o $(BONUS_SERVER)

# Link bonus client
$(BONUS_CLIENT): $(LIBS) $(BASE_OBJ_FILES) $(BONUS_CLIENT_OBJ_FILES)
	$(CC) $(BASE_OBJ_FILES) $(BONUS_CLIENT_OBJ_FILES) $(LDFLAGS) $(LDLIBS) -o $(BONUS_CLIENT)

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
	$(RM) -f $(SERVER) $(CLIENT) $(BONUS_SERVER) $(BONUS_CLIENT)
	$(MAKE) -C $(LIBFT_DIR) fclean

# re
re: fclean all

# debug
debug: CFLAGS += $(DEBUG_FLAGS)
debug: re bonus

.PHONY: all clean fclean re debug bonus
