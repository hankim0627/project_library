package multi.project.library;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

public class ChatHandler implements WebSocketHandler{
	
	public static List<WebSocketSession> list = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionClosed(WebSocketSession arg0, CloseStatus arg1) throws Exception {
		list.remove(arg0);
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession arg0) throws Exception {
		list.add(arg0);
	}

	@Override
	public void handleMessage(WebSocketSession arg0, WebSocketMessage<?> arg1) throws Exception {
		Map<String,Object> map = arg0.getAttributes();
		String loginid = (String)map.get("member_id");
		
		String msg = loginid+" : "+(String) arg1.getPayload(); //메세지
		for(WebSocketSession socket : list){
			WebSocketMessage<String> sendmsg = new TextMessage(msg);
			socket.sendMessage(sendmsg);
		}
	}

	@Override
	public void handleTransportError(WebSocketSession arg0, Throwable arg1) throws Exception {		
	}

	@Override
	public boolean supportsPartialMessages() {
		return false;
	}
	
}
