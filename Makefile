NAME = my_openssl

CC = gcc

CFLAGS = -Wall -Wextra -Werror

SRC_DIR = src
OBJ_DIR = obj

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))


.PHONY: all
all: help

.PHONY: help
help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: $(NAME) ## Build the project

.PHONY: clean
clean: ## Clean object files
	@rm -rf $(OBJ_DIR)

.PHONY: fclean
fclean: clean ## Clean object files and executable
	@rm -f $(NAME)

$(NAME): $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) -o $(NAME)

$(OBJ_DIR): ## Create object directory
	@mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR) # Compile source files to object files
	$(CC) $(CFLAGS) -c  $< -o $@
