import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public aspect BusquedasProducto {
	File file = new File("consultas.log");
	
	pointcut Cambios() : execution(* DVMarket.buscar*(..));
	
	after() : Cambios(){
		LocalDateTime tiempo = LocalDateTime.now();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String tp = tiempo.format(dateTimeFormatter);
		String mensaje = "Eliminacion";
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