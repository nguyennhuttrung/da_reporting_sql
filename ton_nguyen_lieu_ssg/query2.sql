select mb51_union.*,
	mvt.c1_nhom_giao_dich,
	mvt.c2_nhom_giao_dich,
	mvt.c3_nhom_giao_dich,
	zwm07.don_gia*mb51_union.quantity gia_tri
from (
	select
		TO_DATE(month, 'yyyy-mm-dd') "month",
		material,
		material_description,
		plant,
		storage_location,
		movement_type,
		special_stock,
		posting_date,
		material_document,
		material_docitem,
		batch,
		qty_in_unit_of_entry,
		unit_of_entry,
		name_1,
		movement_type_text,
		asset,
		sub_number,
		counter,
		order_1,
		routing_number_for_operations,
		document_header_text,
		document_date,
		qty_in_opun,
		order_price_unit,
		order_unit,
		qty_in_order_unit,
		company_code,
		valuation_type,
		entry_date,
		time_of_entry,
		purchase_order,
		smart_number,
		item,
		warehouse_document,
		warehouse_number,
		ext_amount_in_local_currency,
		sales_value,
		reason_for_movement,
		sales_order,
		sales_order_schedule,
		sales_order_item,
		cost_center,
		customer,
		movement_indicator,
		consumption,
		receipt_indicator,
		supplier,
		sales_order,
		sales_order_item,
		base_unit_of_measure,
		quantity,
		material_doc_year,
		network,
		activity,
		wbs_element,
		reservation,
		item_number_of_reservation,
		stock_segment,
		debit_credit_ind,
		user_name,
		trans_event_type,
		sales_value_inc_vat,
		currency,
		goods_receipt_issue_slip,
		item_automatically_created,
		reference,
		original_line_item,
		multiple_account_assignment
	from
		da_sap_mb51_n1 

	union all

	select
		thang "month",
		material,
		material_description,
		plant,
		storage_location,
		movement_type,
		special_stock,
		posting_date,
		material_document,
		material_docitem,
		batch,
		qty_in_unit_of_entry,
		unit_of_entry,
		name1,
		movement_type_text,
		asset,
		sub_number,
		counter,
		"order",
		routing_number_for_operations,
		document_header_text,
		document_date,
		qty_in_opun,
		order_price_unit,
		order_unit,
		qty_in_order_unit,
		company_code,
		valuation_type,
		entry_date,
		time_of_entry,
		purchase_order,
		smart_number,
		item,
		warehouse_document,
		warehouse_number,
		ext_amount_in_local_currency,
		sales_value,
		reason_for_movement,
		sales_order,
		sales_order_schedule,
		sales_order_item,
		cost_center,
		customer,
		movement_indicator,
		consumption,
		receipt_indicator,
		supplier,
		sales_order1,
		sales_order_item1,
		base_unit_of_measure,
		quantity,
		material_doc_year,
		network,
		activity,
		wbs_element,
		reservation,
		item_number_of_reservation,
		stock_segment,
		debitcredit_ind,
		user_name,
		transevent_type,
		sales_value_inc_vat,
		currency,
		goods_receiptissue_slip,
		item_automatically_created,
		reference,
		original_line_item,
		multiple_account_assignment
	from
		da_sap_mb51_p2
) mb51_union
join da_master_sap_mvt_n1 mvt
on (mvt.movement_type = mb51_union.movement_type)
join (
	select *,
	case
		when value_gt != 0 then value_sl/value_gt
		else 0
	end don_gia
	from da_sap_zwm07_vnp8
) zwm07 
on (
	zwm07.thang = mb51_union.month
	and zwm07.material = mb51_union.material
	and zwm07.c1_nhom_giao_dich = mvt.c1_nhom_giao_dich
)
