alter table entry_tag add constraint entry_tag_fk1 FOREIGN KEY(entry_id) REFERENCES entries(id);
alter table entry_tag add constraint entry_tag_fk1 FOREIGN KEY(tag_id) REFERENCES tags(id);
