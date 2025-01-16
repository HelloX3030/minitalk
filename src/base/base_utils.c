/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   base_utils.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lseeger <lseeger@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/16 12:59:10 by lseeger           #+#    #+#             */
/*   Updated: 2025/01/16 17:31:56 by lseeger          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "include.h"

void	set_one(char *c, int i)
{
	*c |= 1 << i;
}

void	set_zero(char *c, int i)
{
	*c &= ~(1 << i);
}

bool	is_continuation_byte(char c)
{
	return (((unsigned char)c & 0b11000000) == 0b10000000);
}

bool	is_start_byte(char c)
{
	unsigned char	uc;

	uc = (unsigned char)c;
	return ((uc & 0b10000000) == 0 || (uc & 0b11100000) == 0b11000000
		|| (uc & 0b11110000) == 0b11100000 || (uc & 0b11111000) == 0b11110000);
}
