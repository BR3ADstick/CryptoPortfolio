
update crypto_analyis.crypto_prices_ath
	SET BTC=replace(BTC, '$', ' '),
		ETH=replace(ETH, '$', ' '),
        OTHERS=replace(OTHERS, '$', ' '),
        XRP=replace(XRP, '$', ' '),
        SOL=replace(SOL, '$', ' '),
        LUNA=replace(LUNA, '$', ' '),
        DOT=replace(DOT, '$', ' '),
        DOGE=replace(DOGE, '$', ' '),
        ADA=replace(ADA, '$', ' ')
    ;
    
    update crypto_analyis.crypto_prices_ath
	SET BTC=replace(BTC, ' ', ''),
		ETH=replace(ETH, ' ', ''),
        OTHERS=replace(OTHERS, ' ', ''),
        XRP=replace(XRP, ' ', ''),
        SOL=replace(SOL, ' ', ''),
        LUNA=replace(LUNA, ' ', ''),
        DOT=replace(DOT, ' ', ''),
        DOGE=replace(DOGE, ' ', ''),
        ADA=replace(ADA, ' ', '')
    ;
    
    
    select*
    from crypto_analyis.cryptocurrency_current_price
    WHERE Symbol = 'BTC' 
		  or Symbol = 'ETH'
          or Symbol = 'XRP'
          or Symbol = 'SOL'
          or Symbol = 'LUNA'
          or Symbol = 'DOT'
          or Symbol = 'DOGE'
          or Symbol = 'ADA'
				   ;
                   
-- create a new table for peak price 
CREATE TABLE `crypto_analyis`.`peakprice` (
    `Symbol` VARCHAR(10) NOT NULL,
    `PeakPrice` DECIMAL(10, 4) NOT NULL
);

INSERT INTO `crypto_analyis`.`peakprice` (`Symbol`, `PeakPrice`)
VALUES ('BTC', 67566.83), 
	   ('ETH', 4812.09), 
       ('XRP', 1.84),
       ('SOL', 258.93),
       ('LUNA', 99.72),
       ('DOT', 53.88),
       ('DOGE', 0.68),
       ('ADA', 2.97);
       
-- create a new table to single out the cryptocurrency needed for the analysis
create table `crypto_analyis`.`alltimehigh_crypto`(
	`Name` varchar(50) NOT NUll,
    `Symbol` varchar(10) NOT NULL,
    `PriceUsd` decimal(20,11) NOT NULL);
    
INSERT INTO `crypto_analyis`.`alltimehigh_crypto` (
`Name`, `Symbol`, `PriceUsd`)
	select `Name`,
		   `Symbol`,
           `PriceUsd`
	From `crypto_analyis`.`cryptocurrency_current_price`
    WHERE `Symbol` IN ('BTC', 
					 'ETH', 
                     'XRP', 
                     'SOL', 
                     'LUNA', 
                     'DOT', 
                     'DOGE', 
                     'ADA');

-- join the two tables
SELECT 
  `alltimehigh_crypto`.`Name`, 
  `alltimehigh_crypto`.`Symbol`, 
  `PriceUsd`, 
  `PeakPrice`
FROM 
  `crypto_analyis`.`alltimehigh_crypto` 
LEFT JOIN 
  `crypto_analyis`.`peakprice` 
ON 
  `alltimehigh_crypto`.`Symbol` = `peakprice`.`Symbol`;
    
        