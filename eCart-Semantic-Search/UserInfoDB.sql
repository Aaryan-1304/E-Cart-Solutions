--- Table: public.userInfo

-- DROP TABLE IF EXISTS public."userInfo";

-- CREATE TABLE IF NOT EXISTS public."userInfo"
-- (
-- )

-- TABLESPACE pg_default;

-- ALTER TABLE IF EXISTS public."userInfo"
--     OWNER to postgres;
CREATE TABLE user_Info (
    userid VARCHAR(50) PRIMARY KEY,       
    username VARCHAR(100) NOT NULL,      
    userpassword VARCHAR(100) NOT NULL,  
    usertype VARCHAR(50) NOT NULL,       
    created_at TIMESTAMP DEFAULT NOW(),   
    updated_at TIMESTAMP DEFAULT NOW()  
) 

INSERT INTO user_Info (userid, username, userpassword, usertype) 
VALUES 
('1', 'abc', 'pass123', 'admin'),
('2', 'def', 'newpass', 'customer'),
('3', 'ghi', 'mypass', 'seller'),
('4', 'jkl', 'anotherOne', 'wholeseller'),
('5', 'mno', 'redrum', 'sorter');

SELECT * FROM user_Info;
DROP TABLE IF EXISTS user_nfo;