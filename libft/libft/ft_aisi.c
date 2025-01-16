/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_aisi.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lseeger <lseeger@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/20 16:11:20 by lseeger           #+#    #+#             */
/*   Updated: 2025/01/13 16:28:48 by lseeger          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

static bool	check_limits(long long result, bool is_negative)
{
	if (is_negative && -result < INT_MIN)
		return (false);
	else if (!is_negative && result > INT_MAX)
		return (false);
	return (true);
}

bool	ft_aisi(char *str)
{
	long long	result;
	bool		is_negative;

	result = 0;
	is_negative = false;
	if (!str)
		return (false);
	while (*str == ' ')
		str++;
	if (*str == '-')
	{
		is_negative = true;
		str++;
	}
	while (*str)
	{
		if (!ft_isdigit(*str))
			return (false);
		result = result * 10 + *str - '0';
		if (!check_limits(result, is_negative))
			return (false);
		str++;
	}
	return (true);
}
