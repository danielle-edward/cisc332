-- 1. display the information about all the animals currently housed in
-- a given SPCA location
select * from animal a
join animal_location al on al.animal_id = a.id
join spca s on s.business_name = al.business_name
where al.business_name = $spca_local


-- 3. show all the information for all drivers associated
-- with a particular rescue organization.

select * from drivers d
where d.business_name = $driver_org

-- 4. for a particular donor, show which organizations they donated
-- to and the total amount donated (over their lifetime)
select do.made_to as organization from donation do
join transaction t on t.transaction_id = do.transaction_id
where concat(t.fname," ",t.lname) = $donor_name
--assuming donor_name in format "fname lname"


-- 5. show the total amount donated for 2018 to a selected organization.
-- NEED TO GRAB ALL DATES WITHIN 2008, COULD DO ANY YEAR FOR MORE FUNCTIONALITY
select sum(t.amount) as amount_donated from transactions
join donation do on t.transaction_id = do.transaction_id
where do.made_to = $org_name and t.trans_date = $year

-- 6. allow someone to adopt a pet -- show the pets available at a selected
-- shelter and update the information required for the adoption.
-- Be sure to account for any payment made to the shelter for the animal.

-- taken from one, for spca
select * from animal a
join animal_location al on al.animal_id = a.id
join spca s on s.business_name = al.business_name
where al.business_name = $spca_local

-- insert into animal payments
INSERT INTO `animal_payment`(transaction_id,fname,lname,animal_id)
values (:trans_id,'test',:lname,:animal_id)

-- delete medical
DELETE FROM `vet_visit` WHERE animal_id = :id

-- update adoption number
UPDATE `animal` SET adoption = :adoption_id WHERE id = :id



-- 8. show how many animals were rescued during 2018
-- (by any rescue organization).
select count(a.animal_id) as num_saved from animal a
join animal_location al on al.animal_id = a.animal_id
join rescue r on r.business_name = al.business_name
where r.business_name = $rescue AND r.arrival_date = $arrival_date
-- where arrive date is 2018 but can differ for increased FUNCTIONALITY
