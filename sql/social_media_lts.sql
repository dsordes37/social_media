use social_media;

create table users(
	id int auto_increment primary key,
    email varchar(50) unique not null,
    password varchar(255) not null,
    username varchar(50) unique not null,
    full_name varchar(50) not null,
    image varchar(2083) not null default "https://cdn-icons-png.freepik.com/512/64/64572.png",
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    index idx_username (username)
);

create table posts(
	id int auto_increment primary key,
    content varchar(500) not null,
    like_count int default 0,
    comment_count int default 0,
    color varchar(7) default '#808080',
    user_id int not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(user_id) references users(id) on delete cascade
);

create table comments(
	id int auto_increment primary key,
    content varchar(500) not null,
    like_count int default 0,
    user_id int not null,
    post_id int null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key(user_id) references users(id) on delete cascade,
    foreign key(post_id) references posts(id) on delete cascade
);

create table likes(
	id int auto_increment primary key,
    user_id int not null,
    post_id int null,
    comment_id int null,
    created_at timestamp default current_timestamp,
    constraint chk_post_or_comment_like check(
		(post_id is not null and comment_id is null) or
        (post_id is null and comment_id is not null)
    ),
    foreign key(user_id) references users(id) on delete cascade,
    foreign key(post_id) references posts(id) on delete cascade,
    foreign key(comment_id) references comments(id) on delete cascade,
    index idx_likes (user_id, post_id, comment_id)
);

create table follows(
    follower_id int not null,
    following_id int not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    unfollowed_at timestamp null,
    primary key(follower_id, following_id),
    foreign key(follower_id) references users(id) on delete cascade,
    foreign key(following_id) references users(id) on delete cascade,
    index idx_follow (follower_id, following_id)
);

#========================================================================

/*INSERT INTO users (email, password, username, full_name) VALUES
('alice@example.com', 'password123', 'alice123', 'Alice Johnson'),
('bob@example.com', 'securepass456', 'bob_dev', 'Bob Williams'),
('charlie@example.com', 'charlie789!', 'charlie_tech', 'Charlie Brown'),
('david@example.com', 'daveCoder2024', 'dave_coder', 'David Smith'),
('eva@example.com', 'evaDesign2023$', 'eva_design', 'Eva Davis'),
('frank@example.com', 'frankH@cker!', 'frank_hacker', 'Frank Miller'),
('grace@example.com', 'grace2025Web$', 'grace_web', 'Grace Wilson'),
('henry@example.com', 'henryJS987', 'henry_js', 'Henry Martinez'),
('isabel@example.com', 'Isabel@UIUX', 'isabel_uiux', 'Isabel Taylor'),
('jack@example.com', 'jackNODE!2024', 'jack_node', 'Jack Anderson');*/
INSERT INTO users (email, password, username, full_name) VALUES
('alice@example.com', 'hashed_password_1', 'alice123', 'Alice Costa'),
('bob@example.com', 'hashed_password_2', 'bob_the_builder', 'Bob Silva'),
('carla@example.com', 'hashed_password_3', 'carla_dev', 'Carla Mendes'),
('daniel@example.com', 'hashed_password_4', 'dan_d', 'Daniel Souza'),
('eva@example.com', 'hashed_password_5', 'eva88', 'Eva Lima');


/*INSERT INTO posts (content, color, user_id) VALUES
('Explorando novas tecnologias hoje!', '#FFDDC1', 1),
('Acabei de lançar um novo projeto, confira!', '#FFD1DC', 2),
('Alguém recomenda um bom curso de backend?', '#FFABAB', 3),
('Finalizei meu primeiro site com Angular!', '#FFC3A0', 4),
('Hoje é dia de estudar bancos de dados.', '#D4A5A5', 5),
('Fiz uma landing page com design minimalista.', '#E2F0CB', 6),
('Dicas para melhorar performance no frontend?', '#B5EAD7', 7),
('Tentei usar TailwindCSS e gostei muito!', '#C7CEEA', 8),
('React ou Vue? O que vocês preferem?', '#FFDAC1', 9),
('Primeiro deploy no AWS, que emoção!', '#FF9AA2', 10),
('Preciso de feedback no meu portfólio.', '#FFB7B2', 1),
('Criando uma API REST com Node.js.', '#E2F0CB', 2),
('Debugando um problema chato no código...', '#B5EAD7', 3),
('Qual editor de código vocês usam?', '#C7CEEA', 4),
('Refatorando meu código antigo, que nostalgia.', '#FFDAC1', 5),
('Primeiros passos com TypeScript!', '#FF9AA2', 6),
('Vale a pena aprender Python em 2025?', '#FFB7B2', 7),
('Postei um artigo sobre arquitetura de software.', '#E2F0CB', 8),
('Descobri um novo atalho no VS Code!', '#B5EAD7', 9),
('O que vocês acham do Bun? Alguém já usou?', '#C7CEEA', 10);*/
INSERT INTO posts (content, like_count, comment_count, color, user_id) VALUES
('Bom dia, pessoal! 🌞', 2, 1, '#FFB908', 1),
('Acabei de lançar um projeto novo! 💻', 3, 2, '#004BAD', 3),
('Alguém aí joga xadrez? ♟️', 1, 0, '#808080', 2),
('Dica de filme: “A Origem” 🎥', 0, 1, '#002A61', 4),
('Final de semana chegando! 🙌', 4, 3, '#FF5733', 5);

/*INSERT INTO comments (content, user_id, post_id, parent_comment_id) VALUES
('Ótima postagem, muito útil!', 2, 1, NULL),
('Concordo, também gosto de estudar novas tecnologias.', 3, 1, NULL),
('Parabéns pelo projeto! Onde posso ver?', 4, 2, NULL),
('Recomendo o curso da Rocketseat.', 5, 3, NULL),
('Muito bom! Você usou qual framework?', 6, 4, NULL),
('Banco de dados é essencial, eu curto PostgreSQL.', 7, 5, NULL),
('Legal! Manda o link da página?', 8, 6, NULL),
('Dicas? Minifica e usa CDN para assets.', 9, 7, NULL),
('Também gostei do Tailwind, agiliza muito!', 10, 8, NULL),
('Eu prefiro Vue, mais intuitivo.', 1, 9, NULL),
('Parabéns pelo deploy! AWS tem curva de aprendizado.', 2, 10, NULL),
('Posso ver seu portfólio? Quero me inspirar.', 3, 11, NULL),
('Node.js é top, Express facilita muito.', 4, 12, NULL),
('Força no debug! Já passei por isso.', 5, 13, NULL),
('Uso VS Code, com alguns plugins essenciais.', 6, 14, NULL),
('Refatoração é sempre uma viagem no tempo haha.', 7, 15, NULL),
('TypeScript vale muito a pena!', 8, 16, NULL),
('Python é excelente para backend e automação.', 9, 17, NULL),
('Artigo muito bom! Parabéns.', 10, 18, NULL),
('Bun parece promissor, quero testar.', 1, 20, NULL);*/
INSERT INTO comments (content, like_count, user_id, post_id) VALUES
('Adorei! Bom dia pra você também!', 1, 2, 1),
('Quero ver esse projeto! Link?', 2, 1, 2),
('Mandou bem!', 1, 5, 2),
('Ótima dica! Vou assistir.', 0, 3, 4),
('Já tô no clima!', 1, 1, 5),
('Finalmente, preciso descansar!', 2, 2, 5),
('Sábado é sagrado 😄', 1, 4, 5);

/*INSERT INTO likes (user_id, post_id, comment_id) VALUES
(1, 2, NULL), (2, 3, NULL), (3, 4, NULL), (4, 5, NULL),
(5, 6, NULL), (6, 7, NULL), (7, 8, NULL), (8, 9, NULL),
(9, 10, NULL), (10, 1, NULL), (1, NULL, 1), (2, NULL, 2),
(3, NULL, 3), (4, NULL, 4), (5, NULL, 5), (6, NULL, 6),
(7, NULL, 7), (8, NULL, 8), (9, NULL, 9), (10, NULL, 10);*/
-- Likes em posts
INSERT INTO likes (user_id, post_id) VALUES
(2, 1),
(4, 1),
(1, 2),
(5, 2),
(2, 2),
(5, 5),
(3, 5),
(1, 5),
(2, 5);

-- Likes em comments
INSERT INTO likes (user_id, comment_id) VALUES
(3, 1),
(4, 2),
(1, 3),
(5, 6);

/*INSERT INTO follows (follower_id, following_id) VALUES
(1, 2),(1, 3),(1, 5),(2, 1),(2, 7),(3, 6),(3, 8),(3, 10),
(4, 10),(4, 7),(5, 9),(5, 6),(5, 8),(6, 7), (6, 1), (6, 2),
(7, 8), (7, 10), (7, 3), (8, 1), (8, 5), (8, 7), (9, 10), (9,1),
(10, 9), (10, 1), (10, 3);*/
INSERT INTO follows (follower_id, following_id) VALUES
(1, 2),
(1, 3),
(2, 3),
(3, 1),
(4, 5),
(5, 1);




#========================================================================

select * from users;
select * from posts where user_id=5;
select * from comments;
select * from likes;

select * from likes where comment_id=3;
select * from follows where following_id=10;

select u.username, u.full_name, p.content from users u join posts p on u.id=p.user_id;

select id, username, full_name from users where email='alice@example.com' and password='hashed_password_1';



#drop database social_media;
