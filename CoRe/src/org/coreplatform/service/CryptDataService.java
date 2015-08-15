package org.coreplatform.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CryptDataService {

	public static String crypt(String uncrypted) {
		try {
			MessageDigest d = MessageDigest.getInstance("SHA-1");
			d.reset();
			d.update(uncrypted.getBytes());
			return new String(d.digest());
		} catch (NoSuchAlgorithmException ex) {
			Logger.getLogger(CryptDataService.class.getName()).log(Level.SEVERE, null, ex);
		}
		return null;
	}
}