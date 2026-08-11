{foreach $navbar as $item}
    <li menuItemName="{$item->getName()}" class="nav-item{if $item->hasChildren()} dropdown{/if}{if $item->getClass()} {$item->getClass()}{/if}" id="{$item->getId()}">
        <a {if $item->hasChildren()}class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"{else}class="nav-link" href="{$item->getUri()}"{/if}{if $item->getAttribute('target')} target="{$item->getAttribute('target')}"{/if}>
            {if $item->hasIcon()}<i class="{$item->getIcon()}"></i>&nbsp;{/if}
            {$item->getLabel()}
            {if $item->hasBadge()}&nbsp;<span class="badge badge-info">{$item->getBadge()}</span>{/if}
            {if $item->hasChildren()}<b class="caret"></b>{/if}
        </a>
        {if $item->hasChildren()}
            <ul class="dropdown-menu">
            {foreach $item->getChildren() as $childItem}
                <li menuItemName="{$childItem->getName()}"{if $childItem->getClass()} class="{$childItem->getClass()}"{/if} id="{$childItem->getId()}">
                    <a href="{$childItem->getUri()}" class="dropdown-item"{if $childItem->getAttribute('target')} target="{$childItem->getAttribute('target')}"{/if}>
                        {if $childItem->hasIcon()}<i class="{$childItem->getIcon()}"></i>&nbsp;{/if}
                        {$childItem->getLabel()}
                        {if $childItem->hasBadge()}&nbsp;<span class="badge badge-info">{$childItem->getBadge()}</span>{/if}
                    </a>
                </li>
            {/foreach}
            </ul>
        {/if}
    </li>
{/foreach}
