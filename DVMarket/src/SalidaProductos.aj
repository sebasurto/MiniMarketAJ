import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import DVMarket.Compra;
import DVMarket.Item;

public aspect SalidaProductos {
	
	File file = new File("market.log");
	
	pointcut Cambios() : execution(* Compra.borrarItem(Item));
	
	after() : Cambios(){
		LocalDateTime tiempo = LocalDateTime.now();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String tp = tiempo.format(dateTimeFormatter);
		String mensaje = "Eliminacion" + tp;
		writeFile(mensaje);
	}
	
	public void writeFile(String mensaje) {
		try {
			
			String content = mensaje;
			
			if(!file.exists()) {
				file.createNewFile();
			}
			
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(content);
			bw.close();
		} catch (IOException e) {
            e.printStackTrace();
        }
	}
}
