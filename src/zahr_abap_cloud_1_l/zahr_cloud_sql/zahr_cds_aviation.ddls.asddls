@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Aviation Hierarchy - CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZAHR_CDS_AVIATION
with parameters pId :abap.int1
as select from zahr_avi_parent
association [0..*] to ZAHR_CDS_AVIATION as _Aviation on 
$projection.ParentId = _Aviation.Id
{
    key id as Id,
    key parent_id as ParentId,
    aviation_name as AviationName,
    _Aviation
} where id = $parameters.pId;
