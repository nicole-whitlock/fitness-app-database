CREATE TABLE award (
award_id INT PRIMARY KEY auto_increment,
award_name VARCHAR(25) NOT NULL);

CREATE  TABLE challenge ( 
	challenge_id         INT    NOT NULL   PRIMARY KEY auto_increment,
	name                 VARCHAR(100)       NOT NULL,
	duration             INT       NOT NULL,
	date              DATE       NOT NULL,
	award_id             INT    NOT NULL   ,
    FOREIGN KEY (award_id) REFERENCES award(award_id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE  TABLE community ( 
	community_id         INT    NOT NULL   PRIMARY KEY auto_increment,
	comments             VARCHAR(250)       ,
	likes                INT       ,
	ispublic             BOOLEAN );

CREATE  TABLE joins ( 
	PU_Community_id    INT       NOT NULL,
	Challenge_id       INT       NOT NULL,
    PRIMARY KEY( pu_community_id, challenge_id),
	FOREIGN KEY ( Challenge_id ) REFERENCES challenge( challenge_id ) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ( PU_Community_id ) REFERENCES community( community_id ) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE  TABLE milestone ( 
	milestone_id         INT    NOT NULL   PRIMARY KEY auto_increment,
	milestone_name       VARCHAR(25)       NOT NULL,
	award_id             INT    NOT NULL   ,
	FOREIGN KEY ( award_id ) REFERENCES award( award_id ) ON DELETE CASCADE ON UPDATE CASCADE);
    
 CREATE  TABLE user ( 
	user_id              INT    NOT NULL   PRIMARY KEY,
	first_name           VARCHAR(50)       NOT NULL,
	last_name            VARCHAR(50)       NOT NULL,
	account_created      DATETIME       NOT NULL,
	email                VARCHAR(100)       NOT NULL);

CREATE TABLE reaches (
	user_id		INT	NOT NULL,
    milestone_id 	INT NOT NULL,
    PRIMARY KEY (user_id, milestone_id),
    FOREIGN KEY  (user_id) REFERENCES user (user_id),
    FOREIGN KEY (milestone_id) REFERENCES milestone ( milestone_id ));
    
CREATE  TABLE workout ( 
	workout_id           INT    NOT NULL   PRIMARY KEY auto_increment,
	start_time           TIMESTAMP    NOT NULL   ,
	end_time             TIMESTAMP    NOT NULL   ,
	workout_type         VARCHAR(60)      NOT NULL ,
	user_id              INT       NOT NULL,
    workout_date	DATE	NOT NULL,
	FOREIGN KEY ( user_id ) REFERENCES user( user_id ) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT start_end CHECK(end_time > start_time),
    CONSTRAINT cc1 CHECK (workout_type in ('cycling', 'running', 'weight_lifting', 'other')));
    
CREATE  TABLE connects ( 
	User_id            INT      NOT NULL ,
	Community_id      INT       NOT NULL,
    PRIMARY KEY (user_id, community_id),
	FOREIGN KEY ( User_id ) REFERENCES `user`( user_id ) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ( Community_id ) REFERENCES community( community_id ) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE  TABLE cycling ( 
	c_workout_id         INT    NOT NULL   PRIMARY KEY,
	distance             DECIMAL(10,2)       NOT NULL,
	speed                DECIMAL(10,2)       NOT NULL,
	FOREIGN KEY ( c_workout_id ) REFERENCES workout( workout_id ) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE  TABLE running ( 
	r_workout_id         INT    NOT NULL   PRIMARY KEY,
	pace                 DECIMAL(10,2)       NOT NULL,
	distance             DECIMAL(10,2)       NOT NULL,
	FOREIGN KEY ( r_workout_id ) REFERENCES workout( workout_id ) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE  TABLE shared ( 
	workout_id           INT       NOT NULL,
	community_id         INT       NOT NULL,
    PRIMARY KEY (workout_id, community_id),
	FOREIGN KEY ( workout_id ) REFERENCES workout( workout_id ) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ( community_id ) REFERENCES community( community_id ) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE  TABLE weight_lifting ( 
	w_workout_id         INT    NOT NULL   PRIMARY KEY,
	weight               DECIMAL       ,
	FOREIGN KEY ( w_workout_id ) REFERENCES workout( workout_id ) ON DELETE CASCADE ON UPDATE CASCADE);
