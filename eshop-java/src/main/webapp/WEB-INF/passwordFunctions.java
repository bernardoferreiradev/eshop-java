package FrontEnd;

public class passwordFunctions {
	public static String encriptarPassword(String password) {
        char[] encriptada = new char[password.length()];
        char[] array = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
        
        for (int i = 0; i < password.length(); i++) {
            char caractere = password.charAt(i);
            for (int j = 0; j < array.length; j++) {
                if (array[j] == caractere) {
                    encriptada[i] = array[(j + 2) % array.length];
                    break;
                }
            }
        }
        
        return new String(encriptada);
    }
}
