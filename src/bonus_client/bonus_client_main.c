/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bonus_client_main.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lseeger <lseeger@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/16 13:18:30 by lseeger           #+#    #+#             */
/*   Updated: 2025/01/16 18:18:41 by lseeger          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "include.h"

static void	send_char(pid_t pid, char c)
{
	int	i;

	write(1, "Sended char: ", 13);
	ft_write_byte(c);
	write(1, "\n", 1);
	i = 0;
	while (i < 8)
	{
		if (c & 1)
		{
			if (kill(pid, SIGUSR1) == -1)
				exit(1);
		}
		else
		{
			if (kill(pid, SIGUSR2) == -1)
				exit(1);
		}
		c >>= 1;
		usleep(DELAY);
		i++;
	}
}

static void	send_message(pid_t pid, char *message)
{
	int	i;

	i = 0;
	while (message[i])
	{
		send_char(pid, message[i]);
		i++;
	}
	send_char(pid, '\0');
}

int	main(int argc, char **argv)
{
	if (argc != 3)
	{
		ft_printf("Usage: %s [server PID] [message]\n", argv[0]);
		return (1);
	}
	if (ft_aisi(argv[1]) == false)
	{
		ft_printf("Invalid PID\n");
		return (1);
	}
	send_message(ft_atoi(argv[1]), argv[2]);
	return (0);
}
