CREATE DATABASE programacaosql
GO
USE programacaosql
GO

--Exerc�cios:
--1) Fazer em SQL Server os seguintes algoritmos:

--a) Fazer um algoritmo que leia 1 n�mero e mostre se s�o m�ltiplos de 2,3,5 ou nenhum deles
DECLARE  @numero		INT = 7
IF	@numero    % 2 = 0
	PRINT 'O n�mero � multiplo de 2'
IF	@numero		% 3 = 0
	PRINT  'O n�mero � multiplo de 3'
IF  @numero		% 5 = 0
	PRINT 'O n�mero � multiplo de 5'
IF	@numero	 %2 != 0 AND	@numero %  3   != 0		AND		@numero   %  5 !=  0
	PRINT 'O n�mero n�o � multiplo de 2, 3 ou 5'

--b) Fazer um algoritmo que leia 3 n�meros e mostre o maior e o menor
DECLARE		@numero1	INT	= 80
DECLARE		@numero2	INT = 10
DECLARE		@numero3	INT = 7
DECLARE		@maior		INT
DECLARE		@menor		INT
SET		@maior	=	@numero1
IF		@numero2 >	@maior
		SET		@maior	  =	  @numero2
IF		@numero3	>	@maior
		SET		@maior	  =	  @numero3
SET		@menor	= @numero1
IF		@numero2	<	@menor
		SET		@menor	=		@numero2
IF		@numero3	<	@menor
		SET		@menor	=		@numero3

PRINT	'O maior n�mero �: ' + CAST(@maior AS	VARCHAR(10))
PRINT	'O menor n�mero �: ' + CAST(@menor AS	VARCHAR(10))

/*c) Fazer um algoritmo que calcule os 15 primeiros termos da s�rie
1,1,2,3,5,8,13,21,...
E calcule a soma dos 15 termos*/
DECLARE		@termo1		INT		=	1
DECLARE		@termo2		INT		=	1
DECLARE		@SOMA		INT		=	@termo1	+	@termo2

PRINT 'Termos da S�rie'
PRINT	@termo1
PRINT	@termo2

DECLARE		@contador		INT		= 3

WHILE	@contador  <=	15
BEGIN
	DECLARE		@novoTermo		INT	  =		@termo1		+	@termo2
	SET		@soma  =  @soma  +  @novoTermo
	PRINT	@novoTermo
	SET		@termo1		=	@termo2
	SET		@termo2		=	@novoTermo
	SET		@contador	=	@contador	+  1
END

PRINT 'A soma dos 15 termos �: ' + CAST(@soma AS VARCHAR(10));
	

/*d) Fazer um algoritmo que separa uma frase, colocando todas as letras em mai�sculo e em
min�sculo (Usar fun��es UPPER e LOWER)*/
DECLARE		@frase		VARCHAR(100)	=	'Banco de Dados sem duvidas'

PRINT	'Colevati � o melhor professor de ' + @frase

DECLARE @fraseMaiuscula VARCHAR(100) = UPPER(@frase);
DECLARE @fraseMinuscula VARCHAR(100) = LOWER(@frase);

PRINT 'Frase em mai�sculas: ' + @fraseMaiuscula;
PRINT 'Frase em min�sculas: ' + @fraseMinuscula;

--e) Fazer um algoritmo que inverta uma palavra (Usar a fun��o SUBSTRING)
DECLARE		@palavra	VARCHAR(100)	=	'SQL Server'
DECLARE		@tamanho	INT			=	LEN(@palavra)
DECLARE		 @palavraInvertida		VARCHAR(100) = '';
DECLARE		@posicao	INT		=	@tamanho

WHILE	@posicao	>	0
BEGIN
		  SET @palavraInvertida = @palavraInvertida + SUBSTRING(@palavra, @posicao, 1);
		  SET @posicao = @posicao - 1;
END

PRINT 'Palavra original: ' + @palavra;
PRINT 'Palavra invertida: ' + @palavraInvertida;

/*f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
com as regras estabelecidas (N�o usar constraints na cria��o da tabela)
Computador

ID                  Marca                 QtdRAM             TipoHD                QtdHD               FreqCPU
INT (PK)           VARCHAR(40)             INT              VARCHAR(10)            INT               DECIMAL(7,2)

� ID incremental a iniciar de 10001
� Marca segue o padr�o simples, Marca 1, Marca 2, Marca 3, etc.
� QtdRAM � um n�mero aleat�rio* dentre os valores permitidos (2, 4, 8, 16)
� TipoHD segue o padr�o:
o Se o ID dividido por 3 der resto 0, � HDD
o Se o ID dividido por 3 der resto 1, � SSD
o Se o ID dividido por 3 der resto 2, � M2 NVME
� QtdHD segue o padr�o:
o Se o TipoHD for HDD, um valor aleat�rio* dentre os valores permitidos (500, 1000 ou 2000)
o Se o TipoHD for SSD, um valor aleat�rio* dentre os valores permitidos (128, 256, 512)
� FreqHD � um n�mero aleat�rio* entre 1.70 e 3.20

* Fun��o RAND() gera n�meros aleat�rios entre 0 e 0,9999...*/

CREATE TABLE	Computador (
	id		INT	,
	marca	VARCHAR(40),
	qtdRam	INT,
	tipoHd	VARCHAR(10),
	qtdHd	INT,
	freqCpu	DECIMAL	(7,2),
	PRIMARY KEY	(id)
)

DECLARE		@cont	INT	 = 1
DECLARE		@id		INT	 = 10001


WHILE @cont <= 100
BEGIN
    DECLARE @marca VARCHAR(40) = 'Marca' + CAST(@cont AS VARCHAR(10));
    DECLARE @qtdRam INT = CAST(RAND() * 4 + 1 AS INT) * 2;
    DECLARE @tipoHd VARCHAR(10);
    DECLARE @qtdHd INT;
    DECLARE @freqCpu DECIMAL(7,2);

    SET @tipoHd = CASE WHEN @id % 3 = 0 THEN 'HDD'
                       WHEN @id % 3 = 1 THEN 'SSD'
                       ELSE 'M2 NVME'
                  END;
                  
    SET @qtdHd = CASE WHEN  @tipoHd = 'HDD' THEN (CAST(RAND() * 3 AS INT) + 1) * 500
                      WHEN @tipoHd = 'SSD' THEN (CAST(RAND() * 3 AS INT) + 1) * 128
                      ELSE 0
                 END;

    SET @freqCpu = RAND() * (3.20 - 1.70) + 1.70;

    INSERT INTO Computador (id, marca, qtdRam, tipoHd, qtdHd, freqCpu)
    VALUES (@id, @marca, @qtdRam, @tipoHd, @qtdHd, @freqCpu);

    SET @id = @id + 1;
    SET @cont = @cont + 1;
END


SELECT * FROM Computador
