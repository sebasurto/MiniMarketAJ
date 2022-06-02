import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import DVMarket.DVMarket;

public aspect BusquedasProducto {
	File file = new File("consultas.log");
	
	
	pointcut Consultando() : execution(* DVMarket.buscar*(..));
	
	after() : Consultando(){
		LocalDateTime tiempo = LocalDateTime.now();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String tp = tiempo.format(dateTimeFormatter);
		String mensaje = tp + thisJoinPoint.getSignature().getDeclaringType();
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
