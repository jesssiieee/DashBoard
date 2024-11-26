const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const cors = require('cors');
const path = require('path');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: '*',
    }
});

app.use(cors());

app.use('/socket.io', express.static(path.join(__dirname, 'node_modules', 'socket.io', 'client-dist')));

const clients = {};

io.on('connection', (socket) => {
    console.log('New client connected');

    socket.on('register', (data) => {
        console.log(`Client registered as ${data.recipient}`);
        clients[data.recipient] = socket;  // 클라이언트를 recipient로 등록
        socket.join(data.recipient);
    });

    socket.on('message', (data) => {
        console.log(`Message received for ${data.recipient}: ${JSON.stringify(data.message, null, 2)}`);

        const { recipient, message } = data;
        if (recipient === 'all') {
            io.emit('message', data);
        } else if (clients[recipient]) {
            clients[recipient].emit('message', { recipient: recipient, message: message });
        } else {
            io.to(recipient).emit('message', data);
        }
    });

    console.log('New client connected:', socket.id);

    socket.on('sendIp', (data) => {
        console.log(`IP received from client: ${data.ip}`);
        io.emit('sendIp', data); // 모든 클라이언트에 전송
    });

    socket.on('disconnect', () => {
        console.log('Client disconnected:', socket.id);
    });


    socket.on('disconnect', () => {
        console.log('Client disconnected');
        for (let recipient in clients) {
            if (clients[recipient] === socket) {
                delete clients[recipient];
                break;
            }
        }
    });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => console.log(`Server running on port ${PORT}`));

