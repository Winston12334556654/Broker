package app.daos;

import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Authenticator;
import org.springframework.beans.factory.annotation.Autowired;

public class Mail<JavaMailSender> {

    public int otp (int length){
        String numbers = "0123456789";

        Random rndm_method = new Random();

        char[] otp = new char[length];

        for (int i = 0; i < length; i++) {

            otp[i] = numbers.charAt(rndm_method.nextInt(numbers.length()));
        }

        String s =  new String(otp);
        int i = Integer.parseInt(s);
        return i;
    }
    @Autowired
    JavaMailSender mailSender;
    public boolean sendEmail(int otp,String mail) {
        boolean test=false;

        System.out.println("trying");

        String tomail = mail;
        final String frommail = "shalchate2023@gmail.com";
        final String password = "mjzlgpgcwmzrpbvg";

        try {
            Properties pr = new Properties();
            pr.put("mail.smtp.auth", "true");
            pr.put("mail.smtp.starttls.enable", "true");
            pr.put("mail.smtp.host", "smtp.gmail.com");
            pr.put("mail.smtp.port", "587");

            //	pr.put("mail.smtp.socketFactory.port", "587");
            //	pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(frommail, password);
                }
            });


            Message mess = new MimeMessage (session);
            try {
                mess.setFrom(new InternetAddress(frommail));
                mess.setRecipients(Message.RecipientType.TO, InternetAddress.parse(tomail));

                mess.setSubject("User Email Verification.");
                mess.setText("Your Otp is " + otp);
                System.out.println("sending");
            }catch(Exception e){
                e.getMessage();
                e.printStackTrace();
            }

            Transport.send(mess);

            test = true;
            System.out.println("sent");


        }catch(Exception e){
            e.getMessage();
            e.printStackTrace();
        }
        return test;
    }
}