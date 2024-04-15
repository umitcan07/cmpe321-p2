#!/bin/bash

> queries.sql

for i in {0..20}
do
    if [ -f "2020400171_2020400114/query$i.sql" ]; then
        cat "2020400171_2020400114/query$i.sql" >> queries.sql
    else
        echo "2020400171_2020400114/query$i.sql not found."
    fi
done

echo "All queries have been concatenated into queries.sql."
