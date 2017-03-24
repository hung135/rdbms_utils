DELIMITER $$

DROP FUNCTION IF EXISTS `fn_util_list_get` $$
CREATE FUNCTION `fn_util_list_get`(vList longText charset utf8mb4,vDelimiter Text,vPosition Int) RETURNS longtext CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE pos_count INT; 
	DECLARE x1,x2,x3 INT; 
	DECLARE listLen,delimLen  INT; 
	SET x1 = 1;
	SET x2 = 1;
	SET x3 = 1;
	SET pos_count = 1;
	set delimLen=char_length(vDelimiter);

	if vList is null then
		return null;
	else
		set listLen=fn_util_list_len(vList,vDelimiter);
		
	
		
			if (vPosition>listLen) then
				return null;
			elseif (vPosition=0) then
					return vList;
			
			elseif (vPosition=1) then
					set x1=locate(vDelimiter,vList);
					if (x1=0) then
						return vList;
					else 
						return left(vList,locate(vDelimiter,vList)-1);
					end if;
					
			else
				while pos_count<=vPosition do
							set x1=x2;
							set x2=x3;
							if pos_count=1 then
								set x3=locate(vDelimiter,vList,x3);
							else
								set x3=locate(vDelimiter,vList,x3+delimLen);
							end if;
					set pos_count=pos_count+1;
				end while;
				-- return x2;
			  -- return concat(x1,"<-x1-",x2,"<-x2-",x3,"<-x3- len->",listLen,"--start:",x2+delimLen);
					
					if x3=0 then
						return substring(vList,x2+delimLen,char_length(vList)-x2+delimLen);
					else
						return substring(vList,x2+delimLen,x3-(x2+delimLen));
					end if;
			end if;
		end if;
	
	

END $$

DELIMITER ;