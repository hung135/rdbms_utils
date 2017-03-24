DELIMITER $$
/*
Given a Text String and a delimiter string.
This function will return the number of items in the list include blank positions
*/
DROP FUNCTION IF EXISTS `fn_util_list_len` $$
CREATE FUNCTION `fn_util_list_len`(vList longText,vdelimiter varchar(16)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE x INT; 
	SET x = 0;

	if vList is null then
		return x;
	else
	
	set x=(char_length(vList)-char_length(replace(vList,vdelimiter,'')))/char_length(vdelimiter);
	return x+1;
	end if;
	

END $$

DELIMITER ;