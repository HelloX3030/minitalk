/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server_main.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lseeger <lseeger@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/16 13:17:48 by lseeger           #+#    #+#             */
/*   Updated: 2025/01/16 16:46:03 by lseeger          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "include.h"

static void	handle_sig(int signum)
{
	static char	c = 0;
	static int	i = 0;

	if (signum == SIGUSR1)
		set_one(&c, i);
	else if (signum == SIGUSR2)
		set_zero(&c, i);
	i++;
	if (i >= 8)
	{
		ft_printf("%c", c);
		i = 0;
		c = 0;
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
