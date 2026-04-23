-- =========================================
-- 1. CRIAÇÃO DAS TABELAS
-- =========================================

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    cidade VARCHAR(100)
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    modelo VARCHAR(100),
    preco DECIMAL(10,2)
);

CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY,
    nome VARCHAR(100),
    comissao DECIMAL(5,2)
);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    id_vendedor INT,
    data DATE,
    quantidade INT
);

CREATE TABLE estoque (
    id_produto INT,
    quantidade_estoque INT
);

-- =========================================
-- 2. INSERÇÃO DE DADOS (com erros simulados)
-- =========================================

INSERT INTO clientes VALUES
(1, 'João', 25, 'Recife'),
(2, 'Maria', NULL, 'Olinda'),
(3, NULL, 40, 'Recife'),
(4, 'Ana', -5, NULL),
(5, 'Carlos', 35, 'Jaboatão'),
(5, 'Carlos', 35, 'Jaboatão'); -- duplicado

INSERT INTO produtos VALUES
(101, 'Civic', 100000),
(102, 'Corolla', 110000),
(103, 'Onix', NULL),
(104, 'HB20', -50000);

INSERT INTO vendedores VALUES
(10, 'Lucas', 0.05),
(11, 'Fernanda', 0.07),
(12, 'Rafael', NULL);

INSERT INTO vendas VALUES
(1001, 1, 101, 10, '2023-01-10', 1),
(1002, 2, 102, 11, '2023-02-15', 2),
(1003, 3, 103, 12, NULL, NULL),
(1004, 99, 104, 12, '2023-03-01', -3); -- FK inválida + erro

-- =========================================
-- 3. LIMPEZA DE DADOS (ETL EM SQL)
-- =========================================

-- Remover duplicados (exemplo simples)
DELETE FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM clientes
    GROUP BY id_cliente
    HAVING COUNT(*) > 1
);

-- Corrigir idades inválidas
UPDATE clientes
SET idade = NULL
WHERE idade <= 0 OR idade > 100;

-- Substituir valores nulos
UPDATE clientes
SET nome = 'Desconhecido'
WHERE nome IS NULL;

-- Corrigir preços inválidos
UPDATE produtos
SET preco = NULL
WHERE preco <= 0;

-- =========================================
-- 4. CONSULTAS BÁSICAS
-- =========================================

-- Visualizar dados
SELECT * FROM clientes;

-- Filtrar
SELECT * FROM produtos
WHERE preco > 50000;

-- Ordenar
SELECT * FROM vendas
ORDER BY data DESC;

-- =========================================
-- 5. JOINS (ESSENCIAL EM CD)
-- =========================================

SELECT
    v.id_venda,
    c.nome AS cliente,
    p.modelo,
    vd.nome AS vendedor,
    v.quantidade,
    p.preco,
    (v.quantidade * p.preco) AS valor_total
FROM vendas v
LEFT JOIN clientes c ON v.id_cliente = c.id_cliente
LEFT JOIN produtos p ON v.id_produto = p.id_produto
LEFT JOIN vendedores vd ON v.id_vendedor = vd.id_vendedor;

-- =========================================
-- 6. AGREGAÇÕES (ANÁLISE)
-- =========================================

-- Faturamento total
SELECT SUM(v.quantidade * p.preco) AS faturamento_total
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto;

-- Vendas por produto
SELECT
    p.modelo,
    SUM(v.quantidade) AS total_vendido
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.modelo
ORDER BY total_vendido DESC;

-- =========================================
-- 7. CLIENTES MAIS VALIOSOS
-- =========================================

SELECT
    c.nome,
    SUM(v.quantidade * p.preco) AS valor_total
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY c.nome
ORDER BY valor_total DESC;

-- =========================================
-- 8. ANÁLISE TEMPORAL
-- =========================================

SELECT
    EXTRACT(YEAR FROM data) AS ano,
    EXTRACT(MONTH FROM data) AS mes,
    SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY ano, mes
ORDER BY ano, mes;

-- =========================================
-- 9. DETECÇÃO DE PROBLEMAS
-- =========================================

-- Vendas com cliente inexistente
SELECT *
FROM vendas v
LEFT JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE c.id_cliente IS NULL;

-- Produtos com preço inválido
SELECT *
FROM produtos
WHERE preco IS NULL;

-- =========================================
-- 10. VIEW (DADO CONSOLIDADO)
-- =========================================

CREATE VIEW vw_vendas_completas AS
SELECT
    v.id_venda,
    c.nome AS cliente,
    p.modelo,
    vd.nome AS vendedor,
    v.data,
    v.quantidade,
    p.preco,
    (v.quantidade * p.preco) AS valor_total
FROM vendas v
LEFT JOIN clientes c ON v.id_cliente = c.id_cliente
LEFT JOIN produtos p ON v.id_produto = p.id_produto
LEFT JOIN vendedores vd ON v.id_vendedor = vd.id_vendedor;
