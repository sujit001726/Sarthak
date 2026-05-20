package sarthak.websocket;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpointConfig;

public class HttpSessionConfigurator extends ServerEndpointConfig.Configurator {
    @Override
    public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
        Object rawSession = request.getHttpSession();
        if (rawSession instanceof HttpSession session) {
            config.getUserProperties().put("userId", session.getAttribute("userId"));
        }
    }
}
