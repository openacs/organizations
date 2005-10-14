<master>

<property name="title">@title@</property>
<property name="context_bar">@context_bar;noquote@</property>

<table>
<tr>
<th align="right">Name:</th>
<td>@name@</td>
</tr>

<tr>
<th align="right">Legal name:</th>
<td>@legal_name@</td>
</tr>

<tr>
<th align="right">Email:</th>
<td><a href="mailto:@email@">@email@</a></td>
</tr>

<tr>
<th align="right">Website:</th>
<td><a href="@url@">@url@</a></td>
</tr>

<tr>
<th align="right">Registration number:</th>
<td>@reg_number@</td>
</tr>

<tr>
<th align="right">Notes:</th>
<td>@notes@</td>
</tr>
</table>

<ul>
<li><a href="add-edit?organization_id=@organization_id@">edit organization</a>
<if @delete_p@>
   <li><a href="delete?organization_id=@organization_id@">delete organization</a>
</if>

</ul>
