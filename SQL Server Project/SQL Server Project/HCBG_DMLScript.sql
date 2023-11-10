--Find Materials with duplicate Auto ID
select * from Material 
where Auto_Id in (select Auto_Id from Material group by Auto_Id having COUNT(Auto_Id) >= 2)
order by Auto_Id

select m1.Auto_Id, m1.Material_Id from Material m1
inner join Material m2 on m1.Auto_Id = m2.Auto_Id where m1.Material_Id != m2.Material_Id