/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bonus_server_main.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lseeger <lseeger@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/16 13:18:20 by lseeger           #+#    #+#             */
/*   Updated: 2025/01/16 18:28:35 by lseeger          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "include.h"

static void	reset_values(char *c, int *i, int *ii)
{
	c[0] = 0;
	c[1] = 0;
	c[2] = 0;
	c[3] = 0;
	*i = 0;
	*ii = 0;
}

static void	handle_start_byte(char *c, int *i, int *ii)
{
	char	tmp;

	tmp = c[*ii];
	if (*ii > 0)
		write(1, c, *ii);
	reset_values(c, i, ii);
	c[0] = tmp;
	*ii = 1;
}

static void	handle_sig(int signum)
{
	static char	c[4] = {0, 0, 0, 0};
	static int	i = 0;
	static int	ii = 0;

	if (signum == SIGUSR1)
		set_one(&c[ii], i);
	else if (signum == SIGUSR2)
		set_zero(&c[ii], i);
	i++;
	if (i >= 8)
	{
		ft_write_bytes(c, ii + 1);
		write(1, "\n", 1);
		if (is_start_byte(c[ii]))
		{
			handle_start_byte(c, &i, &ii);
			write(1, "\n", 1);
			write(1, "start byte\n", 11);
		}
		else if (ii >= 3 || c[ii] == '\0')
		{
			write(1, c, ii + 1);
			reset_values(c, &i, &ii);
			write(1, "flushed\n", 8);
			write(1, "\n", 1);
		}
		else
		{
			write(1, "next byte\n", 10);
			ii++;
		}
	}
}

int	main(void)
{
	ft_printf("%i\n", getpid());
	if (signal(SIGUSR1, handle_sig) == SIG_ERR)
		return (ft_printstr_fd("Setup SIGUSER1 failed\n", STDERR_FILENO), 1);
	if (signal(SIGUSR2, handle_sig) == SIG_ERR)
		return (ft_printstr_fd("Setup SIGUSER2 failed\n", STDERR_FILENO), 1);
	while (1)
		pause();
	return (0);
}
