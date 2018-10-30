package com.test.rememberTest.Dao.Damege_goods;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import com.test.rememberTest.Dto.Damege_goodsDto;

@Component
public class EmailSender {
	@Autowired
    protected JavaMailSender  mailSender;
	public void SendEmail(Damege_goodsDto email) throws Exception {
        MimeMessage msg = mailSender.createMimeMessage();
        msg.setSubject(email.getSubject());
        msg.setText(email.getContent(),"UTF-8","html");
        msg.setRecipient(RecipientType.TO , new InternetAddress(email.getReceiver()));
        
        mailSender.send(msg); 
    }
}
