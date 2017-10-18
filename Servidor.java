import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;

import java.net.*;
import java.io.*;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import javax.swing.JLabel;

    import java.util.Random;



class Servidor
{//   private native int[] callTorch(int[] b);
	private native int callTorch(int opc);
	private native void startTorch(int opc);
	private native void reporte();
	private int port=0,count=0;
	private boolean bandera =false;
	private byte[] bytes;
	ServerSocket serverSocket = null;
	private int contCaricatura = 0, contFutbol = 0, contDocumental = 0;
	private int contGuerra = 0, contNoticia = 0, contNovela = 0;
	DatagramSocket s;
	private String ruta="/home/alberto/Desktop/servidor/";
Servidor(int port)
{
	this.port=port;
	
}

public void _startTorch(int opc)
{

startTorch(opc);
	
}

	class Color
	{
		int [] colorY=null;
		 int [] colorU=null;
		 int [] colorV=null;
		 Color(int [] y,int [] u,int[] v)
		 {
			 this.colorY=y;
			 this.colorU=u;
			 this.colorV=v;

			 
		 }
		
	}

synchronized public void _thead(int opc,int tiempo) {


        try{
            
            s = new DatagramSocket(null);
	s.setReuseAddress(true);
		        InetSocketAddress address = new InetSocketAddress(this.port);
			s.bind(address);
			DatagramPacket p;
            //System.out.println("Preparando para  recibir datagramas");
			int port;
			InetAddress ip;
			String respuesta;
			
           for(;;){
   
                p = new DatagramPacket(new byte[40000], 40000);
               	s.receive(p);
                String nombre = new String(p.getData(),0,p.getLength());
                p = new DatagramPacket(new byte[40000], 40000);
                s.receive(p);
                DataInputStream dis = new DataInputStream(new  ByteArrayInputStream(p.getData()));
                String nombreArchivo = dis.readUTF();
              //  System.out.println("Datagrama recibido donde "+p.getAddress()+":"+p.getPort()+" nombre archivo "+nombre+" "+nombreArchivo);
				ip = p.getAddress();
				port = p.getPort();
  //              System.out.println("Recibiendo Archivo...");
                DataOutputStream dos=new DataOutputStream(new FileOutputStream(ruta+"profile.png"));


				long k,j;
				k = dis.readLong();
				int n=0;
			//	while(n<k){//cuando vale -1 significa que ya termino de leer :D
				    p = new DatagramPacket(new byte[4000], 4000);
				    s.receive(p);
				    j = p.getLength();
				    dos.write(p.getData(),0, (int) j);
				    n+=j;
			//	System.out.println(n+","+k);
				//}
				int result =callTorch(opc);
			//	System.out.println("resultado "+result);
		String op="";
               switch(result){
            case 1:
		op = "caricatura";
		contCaricatura++;
            break;
            case 2:
   		op = "Documental";
		contDocumental++;
            break;
            case 3:
 		op = "Fútbol";
		contFutbol++;
            break;
            case 4:
 		op = "Guerra";
		contGuerra++;
            break;
            case 5:
 		op = "Noticia";
		contNoticia++;
            break;
            case 6:
 		op = "Novela";
		contNovela++;
            break;
        }
System.out.println("ca"+contCaricatura);
				Main.jLabel8.setText(op);


				respuesta = result+"-"+tiempo;
/*}
else{
	respuesta = "false";
}*/
	
				byte [] b = respuesta.getBytes();
				p = new DatagramPacket(b,b.length,ip,port);
				s.send(p);
				//System.out.println("repuesta "+respuesta+""+ip+" "+port);
				//s.close();
				dis.close();
				dos.close();
escribir();
		//			
				Thread.sleep(tiempo*1000);

			if(Main.aux==10){
			System.out.println("repuesta "+respuesta+""+ip+" "+port);
			reporte();
                        Main.aux=0;
                       return ;
                       }
			}


           
        }catch(Exception e){
            e.printStackTrace();
        }
    }


protected void finalize(){
//Objects created in run method are finalized when
//program terminates and thread exits
     try{
        serverSocket.close();
    } catch (IOException e) {
        System.out.println("Could not close socket");
        System.exit(-1);
    }
  }


static {
    System.loadLibrary("TorchMain");
}

public void escribir()
    {

File f;
f = new File("datos.txt");
//Escritura
try{
FileWriter w = new FileWriter(f);
BufferedWriter bw = new BufferedWriter(w);
PrintWriter wr = new PrintWriter(bw);  
wr.write("Reporte\n"+contCaricatura+"\n"+contDocumental+"\n"+contFutbol+"\n"+contGuerra+"\n"+contNoticia+"\n"+contNovela);
wr.close();
bw.close();
}catch(IOException e){};

 }


}


//			System.exit(0);
