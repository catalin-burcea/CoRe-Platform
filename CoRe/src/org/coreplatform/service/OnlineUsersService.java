package org.coreplatform.service;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Service;


@Service
public class OnlineUsersService {
	public static Set<Integer> onlineUsers = Collections.synchronizedSet(new HashSet<Integer>());
	volatile public static int changed = 0;
}
