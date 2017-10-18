/*import java.io.IOException;
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

    import java.util.Random;

class S
{   private native int[] callTorch(int[] b);
	private native void startTorch();
	private int port=0,count=0;
	private byte[] bytes;
	ServerSocket serverSocket = null;
S(int port)
{
	this.port=port;
}

public void _startTorch()
{
startTorch();
	
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


synchronized public void _thead() {


        try{
            String ruta="/home/alberto/Desktop/";
            DatagramSocket s = new DatagramSocket(9001);
	DatagramPacket p;
            System.out.println("Preparando para  recibir datagramas");
		int port;
		InetAddress ip;
		String respuesta;
           for(;;){
   
                p = new DatagramPacket(new byte[2000], 2000);
                s.receive(p);
   
		         String nombre = new String(p.getData(),0,p.getLength());

                 p = new DatagramPacket(new byte[2000], 2000);
                 s.receive(p);
                DataInputStream dis = new DataInputStream(new  ByteArrayInputStream(p.getData()));
               String nombreArchivo = dis.readUTF();
               System.out.println("Datagrama recibido donde "+p.getAddress()+":"+p.getPort()+" nombre archivo "+nombre+" "+nombreArchivo);
		ip = p.getAddress();
		port = p.getPort();
                System.out.println("Recibiendo Archivo...");
                DataOutputStream dos=new DataOutputStream(new FileOutputStream(ruta+nombre));

long j;//,k;
//k = dis.readLong();
int n=0;
//while(n<k){//cuando vale -1 significa que ya termino de leer :D
    p = new DatagramPacket(new byte[2000], 2000);
    s.receive(p);
    j = p.getLength();
    dos.write(p.getData(),0, (int) j);
    n+=j;
System.out.println(n+",");
//}
System.out.println("Ingrese respuesta");
//respuesta= sc.nextLine();
respuesta = "true";

byte [] b = respuesta.getBytes();
p = new DatagramPacket(b,b.length,ip,port);
s.send(p);
System.out.println("repuesta "+respuesta+""+ip+" "+port);
//s.close();
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

}


//			System.exit(0);


*/


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

    import java.util.Random;

class S
{   private native int[] callTorch(int[] b);
	private native void startTorch();
	private int port=0,count=0;
	private byte[] bytes;
	ServerSocket serverSocket = null;
S(int port)
{
	this.port=port;
}

public void _startTorch()
{
startTorch();
	
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

synchronized public void _thead() 
{



           System.out.println("iniciandio ");


	/*int size=320*240+160*120*2;

	Socket socket=null;
	
	
	InputStream in = null;


	while(true)
	{
	try{
		serverSocket= new ServerSocket( 4141);
		System.out.println("esperando "+count++);
		socket = serverSocket.accept();
		

            ObjectInputStream entrada = new ObjectInputStream(socket.getInputStream());
	    ObjectOutputStream salida = new ObjectOutputStream(socket.getOutputStream());

		byte[] foto=null;
		try{
		foto=(byte[])(entrada.readObject());
		}catch(Exception e){
			System.out.println("error"+e.getMessage());
		}
		if(foto!=null)
		{	
		System.out.println("foto"+foto.length);
		int[] color=new int[foto.length];

		for(int i=0;i<foto.length;i++)
		color[i]=foto[i] & 0xFF;


		int[] r=callTorch(color);
		byte sal[]=new byte[1];
		sal[0]=(byte)r[0];
		salida.writeObject(sal); 

		}

		socket.close();
		serverSocket.close();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("error"+e.getMessage());

			System.exit(0);
		}


	
	}*/


DatagramSocket socketUDP =null;

try {
	int count=0;
       socketUDP = new DatagramSocket(1234);
      byte[] buffer = null;
	DatagramPacket peticion=null;
      int[] color=new int[360*240+(120*160*2)];
              Random rnd = new Random();

      while (true) {
        // Construimos el DatagramPacket para recibir peticiones

	buffer = new byte[63*1024];
        peticion =new DatagramPacket(buffer, buffer.length);

        // Leemos una petición del DatagramSocket
        socketUDP.receive(peticion);
 	socketUDP.setSoTimeout(100);
	int k=0;
	for(int i=0;i<(63*1024);i++)
		color[k++]=buffer[i] & 0xFF;
	
	System.out.println("contador "+(count++));
	//System.out.println("color Y"+(color[0]));

	buffer = new byte[60288];
        peticion =new DatagramPacket(buffer, buffer.length);

        // Leemos una petición del DatagramSocket
        socketUDP.receive(peticion);
 	socketUDP.setSoTimeout(100);
	for(int i=0;i<(60288);i++)
		color[k++]=buffer[i] & 0xFF;

	//System.out.println("color U "+(color[320*240+160*120] +" V "+color[320*240+160*120*2]));
	

        //System.out.print("Datagrama recibido del host: " + peticion.getAddress());
        //System.out.println(" desde el puerto remoto: " +peticion.getPort());
	int[] r=callTorch(color);
	byte[] mensaje=new byte[2];
	mensaje[0]=(byte)r[0];
	mensaje[1]=(byte)(rnd.nextInt()%8);
        // Construimos el DatagramPacket para enviar la respuesta
        DatagramPacket respuesta =new DatagramPacket(mensaje, 2,peticion.getAddress(), peticion.getPort());

        // Enviamos la respuesta, que es un eco
        socketUDP.send(respuesta);
      }

    } catch (SocketException e) {
      System.out.println("Socket: " + e.getMessage());
    } catch (IOException e) {
      System.out.println("IO: " + e.getMessage());
	socketUDP.close();
	 _thead() ;

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

}


//			System.exit(0);


 
