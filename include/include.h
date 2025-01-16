/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   include.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lseeger <lseeger@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/16 12:55:39 by lseeger           #+#    #+#             */
/*   Updated: 2025/01/16 17:32:43 by lseeger          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef INCLUDE_H
# define INCLUDE_H

# include "libft/libft.h"
# include <signal.h>
# include <unistd.h>

# define DELAY 100
# define DELAY_BONUS 120
# define UNICODE_SIZE 4

// base functions
void	set_one(char *c, int i);
void	set_zero(char *c, int i);
bool	is_continuation_byte(char c);
bool	is_start_byte(char c);

// server functions

// client functions

// bonus server functions

// bonus client functions

#endif
